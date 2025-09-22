import { StatusBar, Text, useColorScheme, View } from 'react-native';
import {
  SafeAreaProvider,
  useSafeAreaInsets,
} from 'react-native-safe-area-context';

import { styles } from './styles';

function App() {
  const isDarkMode = useColorScheme() === 'dark';
  const safeAreaInsets = useSafeAreaInsets();

  return (
    <SafeAreaProvider>
      <StatusBar barStyle={isDarkMode ? 'light-content' : 'dark-content'} />
      <View
        style={[
          styles.container,
          isDarkMode ? styles.containerDark : styles.containerLight,
          { paddingBottom: safeAreaInsets.bottom },
        ]}
      >
        <Text
          style={[styles.text, isDarkMode ? styles.textDark : styles.textLight]}
        >
          Djin
        </Text>
      </View>
    </SafeAreaProvider>
  );
}

export default App;
