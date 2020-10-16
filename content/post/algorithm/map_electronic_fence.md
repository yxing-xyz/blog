---
title: "Map electronic fence"
description: "Map electronic fence"
lead: "Map electronic fence" # 导读

# thumbnail: "/img/avatar.jpg" # Thumbnail image
categories:
  - "Algorithm"
tags:
  - "Algorithm"
authorbox: true
pager: true
toc: true
mathjax: true
comments: false
date: 2020-10-16T15:28:00+08:00
draft: false
---

## 地图围栏算法
```php
<?php
$b = [
    [
        120,30
    ],
    [
        110,10
    ],
    [
        130,10
    ]
];
var_dump(isPointInPolygon($b, 120, 28));
var_dump(isPointInPolygon($b, 120, 29.999999999));
/**
 * 判断经纬度是否落在缩小50米的多边形里
 */
function isPointInPolygon($polygon, $lng, $lat) {
    $count = count($polygon);

    if($count < 3) return false;     // 不能构成多边形

    $y = $lng;  // 地址点经度
    $x = $lat;  // 地址点的纬度
    $flag = false; // 射线奇在偶不在

    for($i=0, $j=$count-1; $i<$count; $j = $i++) {
        $y_ = $polygon[$j][0]; //点a的经度
        $x_ = $polygon[$j][1]; //点a的纬度
        $_y = $polygon[$i][0]; //点b的经度
        $_x = $polygon[$i][1]; //点b的纬度

       if( $y == $y_ && $x == $x_ || $y == $_y && $x == $_x) {
           $flag = true; //位于围栏点上
           break;
       }
        //不能两边取=号，因为垂直线段不进入if判断奇偶
        if ($y_ < $y && $y <= $_y || $_y < $y && $y <= $y_) {
            $tmp_x = $_x + ($y - $_y) * ($x_ - $_x) / ($y_ - $_y);
          if($tmp_x == $x) {
              // 位于线段的点上，肯定在围栏里
              $flag = true;
              break;
          }
          if($tmp_x > $x) {
              // 位于线段之下，还需要进一步判断
              $flag = !$flag;
          }
        }
    }

    // 如果在围栏内，需要检测距离是否位于边缘50米内
    if ($flag) {
        for ($i=0, $j=$count-1; $i<$count; $j = $i++) {
            $y_ = $polygon[$j][0];
            $x_ = $polygon[$j][1];
            $_y = $polygon[$i][0];
            $_x = $polygon[$i][1];

            $tmpDistance = getNearestDistance([$y, $x], [[$y_, $x_], [$_y, $_x]]);

            if($tmpDistance < 50) { // 如果在围栏范围内距离围栏最短距离小于50米，默认在围栏范围外
                $flag = false;
                break;
            }
        }
    }

    return $flag;
}

/**
 * 计算经纬度两点之间的距离
 */
function getDistance($lng1, $lat1, $lng2, $lat2) {
    $earthRadius = 6367000; //approximate radius of earth in meters

    $lat1 = ($lat1 * pi() ) / 180;
    $lng1 = ($lng1 * pi() ) / 180;

    $lat2 = ($lat2 * pi() ) / 180;
    $lng2 = ($lng2 * pi() ) / 180;

    $calcLongitude = $lng2 - $lng1;
    $calcLatitude = $lat2 - $lat1;
    $stepOne = pow(sin($calcLatitude / 2), 2) + cos($lat1) * cos($lat2) * pow(sin($calcLongitude / 2), 2);
    $stepTwo = 2 * asin(min(1, sqrt($stepOne)));
    $calculatedDistance = $earthRadius * $stepTwo;

    return round($calculatedDistance);
}
/**
 * 计算收货人经纬度到围栏线段ab的最短距离
 * $point 收获地址c的经纬度，变量结构：[经度，纬度]
 * $segment 变量结构：[[线段a点经度， 线段a点纬度], [线段b点经度， 线段b点纬度]]
 * @return 数字型变量，锐角三角形点到线段的垂直距离， 或者钝角三角形到ab点中最短的距离
 * @author yx yxing.xyz@gmail.com
 */
function getNearestDistance($point, $segment) {
    // $a是角A对应的线段是线段bc的长度
    // $b是角B对应的线段是线段ac的长度
    // $c是角C对应的线段是线段ab的长度
    $a = getDistance($point[0],$point[1], $segment[1][0], $segment[1][1]);
    $b = getDistance($point[0],$point[1], $segment[0][0], $segment[0][1]);
    $c = getDistance($segment[0][0], $segment[0][1], $segment[1][0], $segment[1][1]);

    if ($a*$a >= $b*$b + $c*$c) return $b;
    if ($b*$b >= $a*$a + $c*$c) return $a;

    $l = ($a + $b + $c) / 2;
    $s=sqrt($l*($l-$a)*($l-$b)*($l-$c));
    return 2*$s / $c;
}
```
