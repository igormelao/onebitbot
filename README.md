# [onebitbot]

This project is about one bot that will create and manage a FAQ for a channel  Slack.

![sinatra](https://img.shields.io/badge/sinatra-2.0.0-green.svg)
![docker](https://img.shields.io/docker/automated/jrottenberg/ffmpeg.svg)
![Codeship Status for igormelao/onebitbot](https://app.codeship.com/projects/f80ce9a0-2e96-0135-a146-3a6547c575dc/status?branch=master)


# Basic Overview

A Onebitbot is a bot that help you organize your's FAQ's Team in Slack. It's build in SINATRA and API.AI.

Enjoy it!

# Demo

https://onebit-bot.herokuapp.com/

# How to use it

Invite your chat bot to your Slack Team

# Require
```
  * Sinatra
  * Docker
  * Docker Compose
  * Postgres
  * API.AI
```


# Getting Started

### 1. Do a fork at original repository
```
https://github.com/igormelao/onebitbot
```

### 2. Clone your fork at a local repository

```
git clone yourForkProject
```

### 3. Build you project with docker-compose
```
   at root path os your project run $ docker-compose build      
```

### 4. Run all migrations
```
   at root path os your project run  $ docker-compose run --rm website rake db:create && rake db:migrate && rake db:seeds
```

### 5. How to execute other commands
```
   at root path os your project run  $ docker-compose run --rm website commandName
```

### 6. Start APP
```
   at root path os your project run $ docker-compose up
```

### 7. Test App
```
   at root path os your project run $ docker-compose run --rm website rails rspec
```

## How to contribute to the project

### 1. Add the remote repository source at your local repositoy
```
$ git remote add upstream https://github.com/igormelao/onebitbot
```

### 2. Sync your repository with the original repository
```
$ git fetch upstream
```

### 3. Update your local repository
```
$ git checkout master
$ git merge upstream/master
```

### 4. Work on it and send your changes
```
$ git push origin master
```

### 5. Do a pull request at your fork on GitHub


\\_o_// HAO! Live long and prosper!
