import React from "react";
import {
    View,
    Image,
    Text,
    ScrollView,
    Alert,
  } from 'react-native';
import SDKButton from '../components/SDKButton';

const PhotoResult = ({navigation, route}) => {
  return (
    <View
    style={{
      flex: 1,
      backgroundColor: 'white',
      alignItems: 'center',
      justifyContent: 'space-evenly',
    }}>
    <View style={{ width: "75%", height: "75%" }}>
      <Image source={{uri: "data:image/png;base64," + navigation.state.params.image}} style={{width:"100%", height:"100%"}} resizeMode='contain'></Image>
    </View>

    <SDKButton onPress ={() => navigation.navigate("Home")} backgroundColor='red' textColor='white' text='Tirar outra foto'/>
  </View >
)}

export default PhotoResult;