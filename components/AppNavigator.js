import React from "react";
import { createStackNavigator } from "react-navigation-stack";
import { createAppContainer } from "react-navigation";
import Home from "../screens/Home";
import PhotoResult from "../screens/PhotoResult";

const AppNavigator = createStackNavigator({
    Home: { screen: Home },
    PhotoResult: { screen: PhotoResult }
}, {initialRouteName: "Home" })

export default createAppContainer(AppNavigator);