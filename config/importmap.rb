# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin_all_from 'app/javascript/dist', under: 'dist'