#!/bin/bash

# Professional Test Suite Runner with Detailed Statistics
# Provides comprehensive test analysis and reporting

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$SCRIPT_DIR"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Unicode symbols
CHECK="✓"
CROSS="✗"
ARROW="→"
INFO="ℹ"
WARN="⚠"

echo ""
echo -e "${CYAN}╔════════════════════════════════════════════════════════════════╗${NC}"
echo -e "${CYAN}║${NC}          ${PURPLE}Primitive UI - Comprehensive Test Suite${NC}           ${CYAN}║${NC}"
echo -e "${CYAN}╚════════════════════════════════════════════════════════════════╝${NC}"
echo ""

# Check if we're in the right directory
if [ ! -f "pubspec.yaml" ]; then
    echo -e "${RED}${CROSS} Error: pubspec.yaml not found. Run this from the project root.${NC}"
    exit 1
fi

echo -e "${BLUE}${INFO} Preparing test environment...${NC}"
echo ""

# Clean previous coverage
rm -rf coverage/ 2>/dev/null

# Run tests with detailed output
echo -e "${YELLOW}${ARROW} Executing test suite...${NC}"
echo ""

flutter test \
  --coverage \
  --reporter expanded \
  --test-randomize-ordering-seed random \
  2>&1 | tee test_output.log

TEST_EXIT_CODE=${PIPESTATUS[0]}

echo ""
echo -e "${CYAN}════════════════════════════════════════════════════════════════${NC}"
echo -e "                  ${PURPLE}Detailed Test Analysis${NC}                      "
echo -e "${CYAN}════════════════════════════════════════════════════════════════${NC}"
echo ""

# Parse test results
TOTAL_TESTS=$(grep -c "^[0-9:]\+ +[0-9]\+" test_output.log || echo "0")
# Extract the final test count from the last line (e.g., "00:01 +82: All tests passed!")
PASSED_TESTS=$(tail -1 test_output.log | grep -oE '\+[0-9]+' | grep -oE '[0-9]+' || echo "0")
FAILED_TESTS=$(grep -c "^[0-9:]\+ +[0-9]\+: .* \[E\]" test_output.log || echo "0")
SKIPPED_TESTS=$(grep -c "^[0-9:]\+ +[0-9]\+: .* \[S\]" test_output.log || echo "0")

# Calculate test duration
if [ -f test_output.log ]; then
    DURATION=$(grep "All.*tests passed" test_output.log | grep -o "[0-9]\+:[0-9]\+" | tail -1 || echo "00:00")
else
    DURATION="00:00"
fi

# Component breakdown
echo -e "${BLUE}📊 Test Statistics:${NC}"
echo -e "   ${GREEN}${CHECK} Passed:${NC}  ${GREEN}$PASSED_TESTS${NC}"
echo -e "   ${RED}${CROSS} Failed:${NC}  ${RED}$FAILED_TESTS${NC}"
echo -e "   ${YELLOW}⊘ Skipped:${NC} ${YELLOW}$SKIPPED_TESTS${NC}"
echo -e "   ${CYAN}⏱  Duration:${NC} ${DURATION}"
echo ""

# Component-wise test count
echo -e "${BLUE}📦 Component Test Coverage:${NC}"

declare -A component_tests
for test_file in test/*_test.dart; do
    if [ -f "$test_file" ]; then
        component=$(basename "$test_file" _test.dart)
        count=$(grep -c "testWidgets\|test(" "$test_file" 2>/dev/null || echo "0")
        component_tests["$component"]=$count
    fi
done

# Sort and display
for component in "${!component_tests[@]}"; do
    count=${component_tests[$component]}
    # Format component name
    formatted=$(echo "$component" | sed 's/_/ /g' | awk '{for(i=1;i<=NF;i++)sub(/./,toupper(substr($i,1,1)),$i)}1')
    printf "   ${CYAN}•${NC} %-35s ${GREEN}%3d tests${NC}\n" "$formatted" "$count"
done | sort
echo ""

# Test groups analysis
echo -e "${BLUE}🏷️  Test Groups Executed:${NC}"
grep "group(" test/*_test.dart | sed "s/.*group('\(.*\)'.*/   ${CYAN}•${NC} \1/" | sort -u
echo ""

# Coverage analysis
if [ -f "coverage/lcov.info" ]; then
    echo -e "${BLUE}📈 Code Coverage Report:${NC}"
    
    # Count covered lines
    TOTAL_LINES=$(grep -c "^DA:" coverage/lcov.info 2>/dev/null || echo "0")
    COVERED_LINES=$(grep "^DA:" coverage/lcov.info | grep -c ",1$\|,[2-9][0-9]*$" 2>/dev/null || echo "0")
    
    if [ "$TOTAL_LINES" -gt 0 ]; then
        COVERAGE_PERCENT=$(awk "BEGIN {printf \"%.1f\", ($COVERED_LINES/$TOTAL_LINES)*100}")
        
        # Color based on coverage
        if (( $(echo "$COVERAGE_PERCENT >= 80" | bc -l) )); then
            COLOR=$GREEN
        elif (( $(echo "$COVERAGE_PERCENT >= 60" | bc -l) )); then
            COLOR=$YELLOW
        else
            COLOR=$RED
        fi
        
        echo -e "   ${COLOR}Coverage: ${COVERAGE_PERCENT}%${NC} ($COVERED_LINES/$TOTAL_LINES lines)"
    else
        echo -e "   ${YELLOW}${WARN} Coverage data unavailable${NC}"
    fi
    
    echo -e "   ${CYAN}${INFO} Report:${NC} coverage/lcov.info"
    echo -e "   ${CYAN}${INFO} HTML:${NC} Run 'genhtml coverage/lcov.info -o coverage/html' to generate"
    echo ""
fi

# Test quality metrics
echo -e "${BLUE}🎯 Test Quality Metrics:${NC}"

# Count assertions
TOTAL_EXPECTS=$(grep -r "expect(" test/ | wc -l)
echo -e "   ${CYAN}• Total Assertions:${NC} $TOTAL_EXPECTS"

# Count different test types
WIDGET_TESTS=$(grep -r "testWidgets(" test/ | wc -l)
UNIT_TESTS=$(grep -r "test(" test/ | wc -l)
echo -e "   ${CYAN}• Widget Tests:${NC} $WIDGET_TESTS"
echo -e "   ${CYAN}• Unit Tests:${NC} $UNIT_TESTS"

# Edge case tests
EDGE_CASE_TESTS=$(grep -r "Edge Case\|edge case" test/ | wc -l)
echo -e "   ${CYAN}• Edge Case Tests:${NC} $EDGE_CASE_TESTS"
echo ""

# File listing
echo -e "${BLUE}📂 Test Files Executed:${NC}"
test_count=0
for test_file in test/*_test.dart; do
    if [ -f "$test_file" ]; then
        test_count=$((test_count + 1))
        filename=$(basename "$test_file")
        size=$(wc -l < "$test_file")
        echo -e "   ${CYAN}$test_count.${NC} $filename ${YELLOW}($size lines)${NC}"
    fi
done
echo ""

# Performance insights
echo -e "${BLUE}⚡ Performance Insights:${NC}"
if [ "$PASSED_TESTS" -gt 0 ]; then
    AVG_TIME=$(echo "scale=2; ${DURATION#*:} / $PASSED_TESTS" | bc -l 2>/dev/null || echo "N/A")
    echo -e "   ${CYAN}• Average per test:${NC} ~${AVG_TIME}s"
fi
echo -e "   ${CYAN}• Randomized order:${NC} ${GREEN}✓${NC} (prevents order dependencies)"
echo ""

echo -e "${CYAN}════════════════════════════════════════════════════════════════${NC}"
echo ""

# Final verdict
if [ $TEST_EXIT_CODE -eq 0 ]; then
    if [ "$PASSED_TESTS" -gt 0 ]; then
        echo -e "${GREEN}╔═══════════════════════════════════════════════════════════════╗${NC}"
        echo -e "${GREEN}║${NC}  ${CHECK}${CHECK}${CHECK}  ${GREEN}ALL $PASSED_TESTS TESTS PASSED SUCCESSFULLY!${NC}  ${CHECK}${CHECK}${CHECK}  ${GREEN}║${NC}"
        echo -e "${GREEN}╚═══════════════════════════════════════════════════════════════╝${NC}"
    else
        echo -e "${YELLOW}${WARN} No tests were executed. Check test files.${NC}"
    fi
else
    echo -e "${RED}╔═══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${RED}║${NC}  ${CROSS}${CROSS}${CROSS}  ${RED}TESTS FAILED - REVIEW OUTPUT ABOVE${NC}  ${CROSS}${CROSS}${CROSS}  ${RED}║${NC}"
    echo -e "${RED}╚═══════════════════════════════════════════════════════════════╝${NC}"
    echo ""
    echo -e "${RED}${INFO} Fix the failing tests before proceeding.${NC}"
fi

echo ""

# Cleanup
rm -f test_output.log

exit $TEST_EXIT_CODE
