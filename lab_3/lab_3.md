Here is the markdown content for the Lab 3 instructions from the provided URL.

# Lab 3 - Communicating with GitHub

## Purpose

The systems we build rarely exists exclusively on the device without retrieving and storing information on external services. In this laboration you will practice creating interfaces based on information downloaded from GitHub.

You will be working with:

  * Asynchronous network calls and threads
  * GraphQL or HTTP + REST requests
  * Dynamically altering the interface
  * Multiple screen views

Android with its various framework gives you the opportunity to use several different ways to communicate with external services. Traditionally, HTTP + REST is used together with JSON as a data carrier. Recently, GraphQL has also become more common. GraphQL offers GUI developers a way to choose which data they want out of different back-end services (some also work on the back-end first). For this task, GitHub has done the work for you on the back-end, but you choose yourself if you want to use GraphQL or more traditional REST.

## Task

Create an application that for a given programming language shows which GitHub repositories are recently the most popular. GitHub has a feature to show which projects and developers are most actively discussed during a given time period ([Trending](https://github.com/trending)). GitHub's Trending ranking is based on the number of stars given during a given period of time, with a certain adaptation to stop manipulation from outside. Your task is to create an application that is similar to GitHub's Trending page.

Basic requirements for the application:

  * The application must navigate between multiple screen views
  * Repositories must be sorted based on some metric that shows popularity, such as the current number of stars
  * Fetched repositories must be filtered by a time interval, based on either the date of the latest update or the repository creation date

### User interface examples (these are only for inspiration, you will create your own design)

## Presenting your work

Demonstrate your interface for the lab assistant, the assistant may ask you to explain parts of the code. The assistant tells you how they want you to submit your code.

## Links

  * [GitHub Developer GraphQL API](https://developer.github.com/v4/)
  * [GitHub Developer REST API](https://developer.github.com/v3/)
  * [A GraphQL Client for Android (Java/Kotlin)](https://github.com/apollographql/apollo-android)
  * [A GraphQL client for React Native](https://www.apollographql.com/docs/react/integrations/react-native/)
  * [A GraphQL driver for Flutter](https://pub.dev/packages/graphql_flutter)