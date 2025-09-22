const { getDefaultConfig, mergeConfig } = require('@react-native/metro-config');

/**
 * @type {import('@react-native/metro-config').MetroConfig}
 * @see https://reactnative.dev/docs/metro
 */
const config = {};

module.exports = mergeConfig(getDefaultConfig(__dirname), config);
