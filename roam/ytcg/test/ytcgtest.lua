local parent_dir = string.format("%s/../?.lua", debug.getinfo(1).source:match("@?(.*[/\\])"))

package.path = "D:/roam/ytcg/src/?.lua" ..  ";" .. package.path

