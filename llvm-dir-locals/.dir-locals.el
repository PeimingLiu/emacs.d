((nil . ((eval . (progn
                   (setq workspace-path (projectile-project-root))
                   (add-to-list 'load-path
                                (expand-file-name ".emacs" workspace-path))
                   ;; load mlir-mode, etc.
                   (require 'init-llvm-workspace)))
         ;; projectile-related
         (projectile-enable-caching . t)
         (projectile-project-compilation-dir . "./build-debug")
         (projectile-project-configure-cmd . "cmake ../llvm \
                                              -DMLIR_INCLUDE_INTEGRATION_TESTS=ON \
                                              -DCMAKE_EXPORT_COMPILE_COMMANDS=On\
                                              -DMLIR_ENABLE_BINDINGS_PYTHON=ON \
                                              -DMLIR_INCLUDE_TESTS=ON \
                                              -DLLVM_ENABLE_PROJECTS=mlir \
                                              -DCMAKE_BUILD_TYPE=Debug \
                                              -DLLVM_ENABLE_ASSERTIONS=ON \
                                              -DCMAKE_C_COMPILER=clang  \
                                              -DCMAKE_CXX_COMPILER=clang++")
         (projectile-project-compilation-cmd . "cmake --build .")
         ;; lsp related
         (lsp-clients-clangd-args . ("--clang-tidy" "--completion-style=detailed" "--header-insertion=never" "-j=50" "--background-index" "--all-scopes-completion" "--cross-file-rename" "--compile-commands-dir=/usr/local/google/home/peiming/projects/llvm-project"))
         )))
