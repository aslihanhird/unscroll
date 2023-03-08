// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName

import { application } from "./application"

import ListController from "./list_controller"
application.register("list", ListController)


import ScrollTo from 'stimulus-scroll-to'
const application = Application.start()
application.register('scroll-to', ScrollTo)
