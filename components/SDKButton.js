import React from 'react';
import {
    TouchableOpacity,
    Text,
} from 'react-native';

const SDKButton = (props) => {
    return (
        <TouchableOpacity
            activeOpacity={0.6}
            onPress={props.onPress}
            style={{
                backgroundColor: props.backgroundColor,
                borderRadius: 5,
                width: 150,
                height: 50,
                alignItems: 'center',
                justifyContent: 'center',
            }}>
            <Text style={{ color: props.textColor, fontSize: 18 }}>{props.text}</Text>
        </TouchableOpacity>
    );
}

export default SDKButton;