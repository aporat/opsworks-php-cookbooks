opsworks-php54-app-layer-cookbooks
==================================

AWS OpsWorks layer with support for PHP 5.4 and php application deployment

Initial Setup
=============
1. Create a Stack with a custom cookbook pointing to `git://github.com/aporat/opsworks-php54-app-layer-cookbooks.git`
2. Add a new `Other -> Custom` layer (DO NOT USE THE BUILT IN PHP LAYER)
3. Edit the newly created layer, and add the custom recipes:

** add php54::default, apache2::default, apache2::mod_rewrite to the setip lifetime event
** add phpapp::configure in the configure lifetime event
** add phpapp::deploy in the deploy lifetime event

