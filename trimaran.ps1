$svgw = 1024
$svgh = 768
$svgzoom = 80

function px($p)
{
	$x = $p[0] * $svgzoom + $svgw / 2
	$y = $p[1] * $svgzoom + $svgh / 2
	$x,$y
}

function poligon($a)
{
"<polygon points='"
$a|foreach{
$p = px $_
$x = $p[0]
$y = $p[1]
"$x,$y" 
}
"' style='fill:yellow;stroke:black;stroke-width:1' />
"
}

function path($mx, $my, $rx, $ry, $x_axis_rotation, $large_arc_flag, $sweep_flag, $x, $y)
{
$mp = px @($mx, $my)
$rx += $svgzoom
$ry += $svgzoom
$p = px @($x, $y)

"<path d='M $($mp[0]),$($mp[1]) A $rx,$ry $x_axis_rotation $large_arc_flag, $sweep_flag $($p[0]),$($p[1])' style='fill:yellow;stroke:black;stroke-width:1' />"
}


function hexagon($cx, $cy, $l)
{
	$x1 = -[math]::Sqrt(3) * $l / 2
	$x2 = -$x1
	$y1 = $cy - $l
	$y2 = $cy - $l/2
	$y3 = $cy + $l/2
	$y4 = $cy + $l
	poligon @(
		($cx, $y1),
		($x2, $y2),
		($x2, $y3),
		($cx, $y4),
		($x1, $y3),
		($x1, $y2)
		)
}

function poplavok($cx, $cy, $l, $w)
{
	$l2 = [math]::Sqrt(3) * $w/2
	$x1 = $cx-$w/2
	$x2 = $cx+$w/2
	$y1 = $cy - $l/2
	$y2 = $cy - $l/2 + $l2
	$y3 = $cy + $l/2 - $l2
	$y4 = $cy + $l/2
	poligon @(
		($cx, $y1),
		($x2, $y2),
		($x2, $y3),
		($cx, $y4),
		($x1, $y3),
		($x1, $y2)
		)
}

function horbar($x, $y, $l, $w)
{
	$x1 = $x+$l
	$y1 = $y + $w
	$y2 = $cy - $l/2 + $l2
	$y3 = $cy + $l/2 - $l2
	$y4 = $cy + $l/2
	poligon @(
		($x, $y),
		($x1, $y),
		($x1, $y1),
		($x, $y1)
		)
}

function svg()
{
'<?xml version="1.0" encoding="utf-8" standalone="no"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
 "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">

<head>
  <!-- <meta content="text/html; charset=utf-8" http-equiv="Content-Type" /> -->
  <title> My First SVG Page</title>
</head>

<body>
<svg xmlns="http://www.w3.org/2000/svg" version="1.1"
width="1024px" height="768px">
'


$rebroL = 4
hexagon 0 0 $rebroL
poplavok 0 0 $($rebroL * 2) 0.8

$w = 0.8
$dl = $w / [math]::Sqrt(3)
$x1 = -[math]::Sqrt(3) * $rebroL / 2 + $w/2
$lp = $rebroL + $dl

#poplavok $x1 0 $lp $w
$x1 = -$x1
poplavok $x1 0 $lp $w

$l2 = [math]::Sqrt(3) * $w/2
$x = -[math]::Sqrt(3) * $rebroL / 2
$y = -$lp/2 + $l2
$l = [math]::Sqrt(3) * $rebroL
$w2 = 0.04
horbar $x $y $l $w2

path $x $y $w 1 45 0 1 $($x + $w/2) $(-$lp/2)
path $($x + $w) $y $w 1 45 0 0 $($x + $w/2) $(-$lp/2)

$y += $w2
horbar $x $y $l $w2
$y += $w2
horbar $x $y $l $w2

$y = $lp/2 - $l2 - $w * 3
horbar $x $y $l $w2
$y += $w2
horbar $x $y $l $w2
$y += $w2
horbar $x $y $l $w2

'</body>

</html>'
}

svg > "c:\tmp\2015-05-21\3d\index.htm"
