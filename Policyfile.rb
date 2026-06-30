# frozen_string_literal: true

name 'msys2'

run_list 'msys2::default'

cookbook 'msys2', path: '.'
