
import React, { useEffect, useState } from 'react';
import {
    View,
    Text,
    ScrollView,
    NativeModules,
    NativeEventEmitter,
  } from 'react-native';
import { logger } from 'react-native-logs';
import SDKButton from '../components/SDKButton';

var log = logger.createLogger();

const Home = (props) => {
  const [stateCamera, setStateCamera] = useState('Olá');

  const { UnicoCheckModule } = NativeModules;
  const eventEmitter = new NativeEventEmitter(UnicoCheckModule);

  useEffect(() => {
    eventEmitter.addListener('onSuccess', e => {
      setStateCamera(e.objResult);
      log.info("sucesso-react-native");
      props.navigation.navigate("PhotoResult", {image: e.objResult});
    });

    eventEmitter.addListener('onError', e => {
      setStateCamera(e.objResult);
    });

    return () => {
      eventEmitter.removeAllListeners('onSuccess');
      eventEmitter.removeAllListeners('onError');
    };
  }, []);

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
          <Text style={{ fontSize: 15, color: 'black' }}>Home Page</Text>
        </ScrollView>
      </View>

      <SDKButton onPress ={() => UnicoCheckModule.callDefaultCamera()} backgroundColor='red' textColor='white' text='Camera Default'/>
      <SDKButton onPress ={() => UnicoCheckModule.callSmartCamera()} backgroundColor='green' textColor='white' text='Camera Smart'/>
      <SDKButton onPress ={() => UnicoCheckModule.callLivenessCamera()} backgroundColor='gray' textColor='white' text='Camera Liveness'/>
      <SDKButton onPress ={() => UnicoCheckModule.callDocumentRGFrontCamera()} backgroundColor='blue' textColor='white' text='RG Frente'/>
      <SDKButton onPress ={() => UnicoCheckModule.callDocumentRGBackCamera()} backgroundColor='blue' textColor='white' text='RG Verso'/>
    </View >
  )
}
export default Home;