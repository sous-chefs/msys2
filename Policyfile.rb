# frozen_string_literal: true

name 'msys2'

run_list 'test::default'

cookbook 'msys2', path: '.'
cookbook 'test', path: './test/cookbooks/test'
