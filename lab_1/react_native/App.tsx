import React, { useState } from 'react';
import {
  SafeAreaView,
  StyleSheet,
  View,
  Text,
  Image,
  TextInput,
  TouchableOpacity,
  StatusBar,
} from 'react-native';

const App = () => {
  const [email, setEmail] = useState('');

  return (
    <SafeAreaView style={styles.container}>
      <StatusBar backgroundColor="#009688" />
      
      {/* Top Bar */}
      <View style={styles.topBar}>
        <Text style={styles.topBarTitle}>Example 3: React Native</Text>
      </View>

      <View style={styles.content}>
        {/* Image */}
        <View style={styles.imageContainer}>
             {/* Placeholder for the circular image */}
            <View style={styles.image}>
                <Text>IMAGE</Text>
            </View>
        </View>

        {/* Buttons Grid */}
        <View style={styles.buttonGrid}>
          <View style={styles.row}>
            <TouchableOpacity style={styles.button}>
              <Text style={styles.buttonText}>BUTTON</Text>
            </TouchableOpacity>
            <TouchableOpacity style={styles.button}>
              <Text style={styles.buttonText}>BUTTON</Text>
            </TouchableOpacity>
          </View>
          <View style={styles.row}>
            <TouchableOpacity style={styles.button}>
              <Text style={styles.buttonText}>BUTTON</Text>
            </TouchableOpacity>
            <TouchableOpacity style={styles.button}>
              <Text style={styles.buttonText}>BUTTON</Text>
            </TouchableOpacity>
          </View>
        </View>

        {/* Email Input */}
        <View style={styles.inputContainer}>
          <Text style={styles.label}>Email</Text>
          <TextInput
            style={styles.input}
            value={email}
            onChangeText={setEmail}
            placeholder=""
            keyboardType="email-address"
          />
        </View>
      </View>
    </SafeAreaView>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#fff',
  },
  topBar: {
    height: 56,
    backgroundColor: '#009688',
    justifyContent: 'center',
    paddingHorizontal: 16,
  },
  topBarTitle: {
    color: '#fff',
    fontSize: 20,
    fontWeight: 'bold',
  },
  content: {
    flex: 1,
    alignItems: 'center',
    padding: 16,
  },
  imageContainer: {
    marginTop: 32,
    marginBottom: 32,
  },
  image: {
    width: 150,
    height: 150,
    borderRadius: 75, // Circular
    backgroundColor: '#ddd', // Placeholder color
    justifyContent: 'center',
    alignItems: 'center',
  },
  buttonGrid: {
    marginBottom: 64,
  },
  row: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    marginBottom: 16,
  },
  button: {
    backgroundColor: '#e0e0e0',
    paddingVertical: 10,
    paddingHorizontal: 20,
    marginHorizontal: 8,
    borderRadius: 4,
    minWidth: 100,
    alignItems: 'center',
  },
  buttonText: {
    fontSize: 14,
    fontWeight: 'bold',
    color: '#000',
  },
  inputContainer: {
    flexDirection: 'row',
    alignItems: 'center',
    width: '100%',
    paddingHorizontal: 16,
  },
  label: {
    fontSize: 16,
    marginRight: 16,
    color: '#888',
  },
  input: {
    flex: 1,
    borderBottomWidth: 1,
    borderBottomColor: '#ff4081', // Pink-ish underline like in the example
    paddingVertical: 4,
    fontSize: 16,
  },
});

export default App;