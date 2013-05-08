# liquidprompt

This module installs the [LiquidPrompt](https://github.com/nojhan/liquidprompt)

# Usage

Liquid prompt is installed (currently) on a per-user basis using the `liquidprompt::user` resource:

```
liquidprompt::user{'name': }
```

This will install liquidprompt for that user using the default settings.

# Dependencies

* [git](https://github.com/nesi/puppet-git)

# References

* [LiquidPrompt homepage](http://www.webupd8.org/2013/04/liquid-prompt-adaptive-prompt-for-bash.html)

# Attribution

This module is derived from the puppet-liquidprompt module by Aaron Hicks (aethylred@gmail.com)

* https://github.com/Aethylred/puppet-liquidprompt

This module has been developed for the use with Open Source Puppet (Apache 2.0 license) for automating server & service deployment.

* http://puppetlabs.com/puppet/puppet-open-source/

# Gnu General Public License

This file is part of the liquidprompt Puppet module.

The liquidprompt Puppet module is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

The liquidprompt Puppet module is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with the liquidprompt Puppet module.  If not, see <http://www.gnu.org/licenses/>.