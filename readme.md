
# Project - schichtplan_apex_2024

Your project **schichtplan_apex_2024** has been successfully created. 
Scripts have been added inside directory: `db/_setup` that allow you 
to create the respective schemas, workspaces as well as ACLs and features, as long 
as you specified them during the configuration. 

schichtplan_apex_2024 - directory structure
```
|-- _depot                 >> Path to store your build artifacts
|-- _logs                  >> Path to store installation logs to
|-- .dbFlow                >> dbFlow itself
|-- .hooks                 >> Scripts/Tasks to run pre or post deployment
|-- apex                   >> APEX applications in subfolders (f123)
|-- db                     >> All DB Schemas used
|   |-- _setup             >> Scripts to create schemas, features, workspaces, ...
|   |-- .hooks             >> Scripts/Tasks to run pre or post db schema deployments
|   |-- schichtplan_apex_2024 >> Main DB Schema mostly used for SingleMode
|-- reports                >> Place all your binaries for upload in a seperate folder here
|-- rest                   >> REST Modules
|   |-- access             >> Place all your privileges, roles and clients here (plsql)
|   |-- modules            >> The REST modules inside seperate folders
|-- static                 >> StaticFiles used to uploads go here (managed by dbFlux)
apply.env                  >> Environment configuration added to .gitignore
build.env                  >> Project configuration
```

To execute the installation just run: `.dbFlow/setup.sh --install`

>For your daily work I recommend the use of the extension: 
>**dbFlux** - https://marketplace.visualstudio.com/items?itemName=MaikMichel.dbflow
>
>For more information refer to readme: `.dbFlow/readme.md`

To configure changelog settings, just modify corresponding parameters in `build.env`

Keep in mind that the script to create the workspace **schichtplan_apex_2024** will drop the one with the same name!
## dbFlow CheatSheet

### Setup / Configuration

#### Install setup (Only Once)
Prepared Scritps in folder `db/_setup` will be run

```bash
.dbFlow/setup.sh --install
```
> !!! => Will remove users/schemas when running in force mode


### Deployment

#### Build initial deployment
All files will be bundeled and install files will be generated

```bash
.dbFlow/build.sh --init --version 1.0.0
```

The deployment artefact will be placed in the configured depot folder

#### Apply initial deployment
Deplyment artifact will be unpacked in current folder and installation routines will run

```bash
.dbFlow/apply.sh --init --version 1.0.0
```
> !!! Initial deployments will clear all included schemas at beginning

#### Build patch deployment
Any files that have been changed between commits, or between tags, will be bundled together and install files will be generated.

```bash
.dbFlow/build.sh --patch --version 1.0.0 --start commit-a --end commit-b
```

Deployment artifact will be placed in configured depot folder

#### Apply initial deployment
Deployment artefact will be unpacked in current folder and installation routines will run

```bash
.dbFlow/apply.sh --patch --version 1.0.0
```

