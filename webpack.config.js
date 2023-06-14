const { VueLoaderPlugin } = require('vue-loader');
const webpack = require('webpack')
const path = require('path');

const env = process.env.NODE_ENV || 'development';

module.exports = {
  entry: {
    'main': './app/javascript/views/main.ts',
    'question/show/main': './app/javascript/views/question/show/main.ts',
    'question/edit/main': './app/javascript/views/question/edit/main.ts',
    'question/new/main': './app/javascript/views/question/new/main.ts',
    'mypage/show/main': './app/javascript/views/mypage/show/main.ts',
    'profile/show/main': './app/javascript/views/profile/show/main.ts',
  },
  output: {
    filename: '[name].js',
    path: path.resolve(__dirname, 'app/javascript/dist'),
  },
  mode: env,
  module: {
    rules: [
      {
        test: /\.vue$/,
        loader: 'vue-loader',
      },
      {
        test: /\.ts$/,
        loader: 'ts-loader',
        options: {
          appendTsSuffixTo: [/\.vue$/]
        }
      },
      {
        test: /\.js$/,
        loader: 'babel-loader'
      },
      {
        test: /\.scss$/,
        use: [
          'vue-style-loader',
          'css-loader',
          'sass-loader'
        ]
      },
      {
        test: /\.css$/,
        use: [
          'style-loader',
          'css-loader',
        ]
      }
    ]
  },
  resolve: {
    alias: {
      'vue$': '@vue/runtime-dom',
      '~': path.resolve(__dirname, 'app/javascript/views')
    },
    extensions: ['.js', '.ts', '.vue'],
  },
  plugins: [
    new VueLoaderPlugin(),
    new webpack.DefinePlugin({
      __VUE_OPTIONS_API__: true,
      __VUE_PROD_DEVTOOLS__: false
    })
  ]
}