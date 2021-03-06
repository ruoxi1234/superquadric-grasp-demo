#!/usr/bin/lua

require("yarp")
require("rfsm")

yarp.Network()

shouldExit = false

-- initialization

grasp_demo_port = yarp.Port()
memory_port = yarp.Port()
grasp_motion_port = yarp.Port()
grasp_attention_port = yarp.Port()


-- load state machine model and initalize it

rf = yarp.ResourceFinder()
rf:setDefaultContext("superquadric-grasp-demo/lua")
rf:configure(arg)
fsm_file = rf:findFile("grasping_root_fsm.lua")
fsm_model = rfsm.load(fsm_file)
fsm = rfsm.init(fsm_model)
rfsm.run(fsm)

repeat
    rfsm.run(fsm)
    yarp.Time_delay(1.0)
until shouldExit ~= false

print("finishing")
-- Deinitialize yarp network
yarp.Network_fini()
