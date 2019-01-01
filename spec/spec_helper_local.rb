# We use some libraries from puppetlabs-inifile, and need to make sure we can
# access it from the tests. It is already available at runtime with `puppet
# agent` and `puppet apply`, so this should be okay...
$:.unshift File.expand_path('./fixtures/modules/inifile/lib', File.dirname(__FILE__))

# vim: ts=2 sts=2 sw=2 expandtab
