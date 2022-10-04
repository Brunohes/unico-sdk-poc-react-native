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
    <View style={{ height: 200 }}>
      <ScrollView>
        <Text style={{ fontSize: 15, color: 'black' }}>Photo Result Page</Text>
        <Image source={{uri: "data:image/png;base64," + navigation.state.params.image}} style={{width:"100%", height:200}} resizeMode='contain'></Image>
      </ScrollView>
    </View>

    <SDKButton onPress ={() => navigation.navigate("Home")} backgroundColor='red' textColor='white' text='Tirar outra foto'/>
  </View >
)}

export default PhotoResult;