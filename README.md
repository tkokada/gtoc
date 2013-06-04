# gtoc is a simple library that converts a geographic coordinate to a Cartesian coordinate in Ruby.
====

## Overview
---
This library converts a geographic coordinate that consists of a north latitude and an east longitude, to a Cartesian coordinate that consists of a reference geographic coordinate, an x coordinate and a y coordinate.
The unit of latitude and longitude is decimal degree. The unit of x and y is meter.
Unfortunately this library currently supports **Japanese** coordinate only.
Most of the equations are referred from [this web page](http://vldb.gsi.go.jp/sokuchi/surveycalc/algorithm/).


## QuickStart
---
This software works on **Ruby**. After installing **Ruby**, a sample in bin directory works simply as follows:

    ruby bin/gtoc *args
    
You can check the arguments of the application. For example, you want to get the x-y coordinates of 33.0 north latitude and 129.5 east longitude, executes the application as follows:

	ruby bin/gtoc -e 33.0 -n 129.5 -m 1

-m option specifies the reference geographic coordinate. If you want to know the details, please check [this web page](http://vldb.gsi.go.jp/sokuchi/patchjgd/download/Help/jpc/jpc.htm). (The web page is in Japanese, but you can set your reference geographic coordinate as library use.)
You can get an x-y coordinate in world geodetic datum if -t option is specified. 

    ruby bin/gtoc -e 33.0 -n 129.5 -m 1 -t "world"

The default value of -t option is "japan".


## How to Use
---
An easiest way to know how to use the library, is to check bin/gtoc.

	require 'gtoc'
	include Geographic
	
	gtoc(latitude: 33.0, longitude: 129.5, number: 1, type: "world")
	=> {x:=>0.0, y:=>0.0, m:=>0.9999}
	
`gtoc` returns a hash including a x coordinate, a y coordinate and a point scale factor.
As explained above, latitude is a north latitude, longitude is an east longitude, number is a reference geographic coordinate number and type is a type of geodetic datum. If you want to specify your own reference geographic coordinate,

	gtoc(latitude: 33.0, longitude: 129.5, default_latitude: 32.9, default_longitude: 129.4)
	=> {x:=>11093.689031, y:=>9344.3898872, m=>0.9999011}
	
If the inputted arguments are invalid or the point scale factor is too large, `gtoc` returns nil and the point scale factor.

	gtoc(latitude: 33.0, longitude: 129.5, number: 0)
	=> {x:=>nil, y:=>nil, m=>nil}

	gtoc(latitude: 33.0, longitude: 139.5, default_latitude: 32.9, default_longitude: 129.4)
	=> {x:=>nil, y:=>nil, m=>1.0194529}


## Document
---
Rdoc document can be generated as follows:

	rake rdoc


## Test
---
Unit test can be done as follows:

	rake test
	

## Reference
---
Equations used in codes: [http://vldb.gsi.go.jp/sokuchi/surveycalc/algorithm/](http://vldb.gsi.go.jp/sokuchi/surveycalc/algorithm/)

Reference geographic coordinates: [http://vldb.gsi.go.jp/sokuchi/patchjgd/download/Help/jpc/jpc.htm](http://vldb.gsi.go.jp/sokuchi/patchjgd/download/Help/jpc/jpc.htm)