-- premake5.lua

workspace "gurl"
    location "output"
    configurations { "Debug", "Release" }

--gurl = {}

--function gurl.GetNil()
--	return nil
--end

include "base.lua"
include "gtest.lua"
include "gmock.lua"