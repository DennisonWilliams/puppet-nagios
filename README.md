puppet-nagios
==============

Description
-----------

A Puppet report handler for sending notifications of failed runs to
nagios via send-nsca.

Requirements
------------

* `puppet`

Installation & Usage
--------------------

1.  Copy the `nagios.yaml` file you created in Step 3. into your `/etc/puppet/` directory.

2.  Install puppet-nagios as a module in your Puppet master's module
    path.

3.  Enable pluginsync and reports on your master and clients in `puppet.conf`

        [master]
        report = true
        reports = nagios
        pluginsync = true
        [agent]
        report = true
        pluginsync = true

4.  Run the Puppet client and sync the report as a plugin

Author
------

Dennison Williams <dennison.williams@gmail.com>
Forked from: James Turnbull <james@lovedthanlost.net>

License
-------

    Author:: Dennison Williams (<dennison.williams@gmail.com>)
    Copyright:: Copyright (c) 2012 Dennison Williams
    License:: GPL, v3
