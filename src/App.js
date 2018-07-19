/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * @format
 * @flow
 */

import React, {Component} from 'react'
import {Platform, StyleSheet, Text, View, TextInput, Button} from 'react-native'
import testID from './helper/testID'

const instructions = Platform.select({
  ios: 'Press Cmd+R to reload,\n' + 'Cmd+D or shake for dev menu',
  android:
    'Double tap R on your keyboard to reload,\n' +
    'Shake or press menu button for dev menu',
});

export default class App extends Component {
  constructor (props) {
    super (props)
    this.state = {
      inputText: ''
    }
  }

  render() {
    return (
      <View style={styles.container}>
        <Text {...testID('welcome-message')} style={styles.welcome}>Welcome to React Native!</Text>
        <Text style={styles.instructions}>To get started, edit App.js</Text>
        <Text style={styles.instructions}>{instructions}</Text>
        <TextInput
          {...testID('input-field')}
          placeholder="Input Here"
          onChangeText={ text => this.setText(text) }
          value={this.state.inputText}
        />
        { this.displayAlert() }
        <Button
          {...testID('click-button')}
          title="Click"
          onPress={() => {
              this.setText('Button was clicked')
          }}
        />
      </View>
    );
  }

  displayAlert () {
    if (this.state.inputText && this.state.inputText !== '') {
      return <Text {...testID('alert-message')}>{this.state.inputText}</Text>
    }
  }

  setText (text) {
    this.setState(previousState => {
        return { inputText: text }
    })
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#F5FCFF',
  },
  welcome: {
    fontSize: 20,
    textAlign: 'center',
    margin: 10,
  },
  instructions: {
    textAlign: 'center',
    color: '#333333',
    marginBottom: 5,
  },
});
