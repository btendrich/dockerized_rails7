# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin_all_from "app/javascript/controllers", under: "controllers"
pin "stimulus-use", to: "https://ga.jspm.io/npm:stimulus-use@0.41.0/dist/index.js"
pin "hotkeys-js", to: "https://ga.jspm.io/npm:hotkeys-js@3.12.0/dist/hotkeys.esm.js"
pin "stimulus", to: "https://ga.jspm.io/npm:stimulus@2.0.0/dist/stimulus.umd.js"
pin "stimulus-use/hotkeys", to: "https://ga.jspm.io/npm:stimulus-use@0.52.0/dist/hotkeys.js"
