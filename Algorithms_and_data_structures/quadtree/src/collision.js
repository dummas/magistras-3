/*
    The MIT License

    Copyright (c) 2011 Mike Chambers

    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"), to deal
    in the Software without restriction, including without limitation the rights
    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    copies of the Software, and to permit persons to whom the Software is
    furnished to do so, subject to the following conditions:

    The above copyright notice and this permission notice shall be included in
    all copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
    THE SOFTWARE.
*/

var stage;
var quadStage;
var circles;
var tree;

var CIRCLE_COUNT = 0;
var bounds;
var shape;
var fps;
var showOverlay = true;


function init()
{
    
    if(!(!!document.createElement('canvas').getContext))
    {
        var d = document.getElementById("canvasContainer");
        d.innerHTML = "This example requires a browser that supports the HTML5 Canvas element."
        return;
    }
    
    circles = [];
    
    var canvas = document.getElementById("canvas");
    var quadCanvas = document.getElementById("quadCanvas");
    quadStage = new Stage(quadCanvas);
    
    bounds = new Rectangle(0,0, quadCanvas.width, quadCanvas.height);
    
    stage = new Stage(canvas);
    shape = new Shape();
    tree = new QuadTree(bounds, false, 7);
    
    fps = new Text();
    fps.x = 100;
    fps.y = 15;
    
    stage.addChild(fps);
    
    quadStage.addChild(shape);
    
    var params = parseGetParams();
    
    //initCircles();
    
    stage.update();
    quadStage.update();

    quadCanvas.onclick = function (e) {
        var x = e.clientX - quadCanvas.offsetParent.offsetLeft;
        var y = e.clientY;
        
        initCircle(x, y);

        updateTree();

        CIRCLE_COUNT = CIRCLE_COUNT + 1;
    }
    
    this.tick = tick_quad;
    
    Ticker.setFPS(24);
    //Ticker.setPaused(true);
    Ticker.addListener(stage);
    Ticker.addListener(window);
}

/** Initialize the circle */
function initCircle(x, y)
{

    radius = 10;
    c = new Circle(bounds, radius);

    if(x + c.width > bounds.width)
    {
        x = bounds.width - c.width - 1;
    }
    
    if(y + c.height > bounds.height)
    {
        y = bounds.height - c.height - 1;
    }
    
    c.x = x;
    c.y = y;
    
    stage.addChild(c);
    circles.push(c);
    tree.insert(c);

}


function updateTree()
{
    //todo: call clear
    
    //tree = new QuadTree(bounds);
    //tree.insert(circles);
    
    tree.clear();
    tree.insert(circles);
}

function tick_quad()
{   
    fps.text = "Balls : " + CIRCLE_COUNT + " / " + Math.round(Ticker.getMeasuredFPS()) + " fps";
    for(var k = 0; k < CIRCLE_COUNT; k++)
    {
        circles[k].update();    
    }
    updateTree();
    
    
    if(showOverlay)
    {
        renderQuad();
    }
    
    var items;
    var c;
    var len;
    var item;
    var dx, dy, radii;
    var colliding = false;
    

    for(var i = 0; i < CIRCLE_COUNT; i++)
    {
        c = circles[i];

        items = tree.retrieve(c);
        len = items.length;
        for(var j = 0; j < len; j++)
        {
            item = items[j];
            
            if(c == item)
            {
                continue;
            }
            
            if(c.isColliding && item.isColliding)
            {
                continue;
            }
            
            dx = c.x - item.x;
            dy = c.y - item.y;
            radii = c.radius + item.radius;     
            
            colliding = (( dx * dx )  + ( dy * dy )) < (radii * radii);
            
            if(!c.isColliding)
            {
                c.setIsColliding(colliding);
            }
            
            if(!item.isColliding)
            {
                item.setIsColliding(colliding);
            }
        }
    }
    stage.update();
    
    if(showOverlay)
    {
        quadStage.update();
    }
}

function tick_brute()
{   
    fps.text = Math.round(Ticker.getMeasuredFPS());
    for(var k = 0; k < CIRCLE_COUNT; k++)
    {
        circles[k].update();    
    }
    updateTree();
    
    
    if(showOverlay)
    {
        renderQuad();
    }
    
    var items;
    var c;
    var len;
    var item;
    var dx, dy, radii;
    var colliding = false;
    

    for(var i = 0; i < CIRCLE_COUNT; i++)
    {
        c = circles[i];

        for(var j = i + 1; j < CIRCLE_COUNT; j++)
        {
            item = circles[j];
            
            if(c == item)
            {
                continue;
            }
            
            if(c.isColliding && item.isColliding)
            {
                continue;
            }
            
            dx = c.x - item.x;
            dy = c.y - item.y;
            radii = c.radius + item.radius;     
            
            colliding = (( dx * dx )  + ( dy * dy )) < (radii * radii);
            
            if(!c.isColliding)
            {
                c.setIsColliding(colliding);
            }
            
            if(!item.isColliding)
            {
                item.setIsColliding(colliding);
            }
        }
    }
    stage.update();
    
    if(showOverlay)
    {
        quadStage.update();
    }
}

function renderQuad()
{
    var g = shape.graphics;
    g.clear();
    g.setStrokeStyle(5);
    g.beginStroke("#333");
    
    drawNode(tree.root);
}

function drawNode(node)
{
    var bounds = node._bounds;
    var g = shape.graphics;

    g.drawRect(
            abs(bounds.x)  + 0.5,
            abs(bounds.y) + 0.5,
            bounds.width,
            bounds.height
        );
    
    var len = node.nodes.length;
    
    for(var i = 0; i < len; i++)
    {
        drawNode(node.nodes[i]);
    }
    
}

//fast Math.abs
function abs(x)
{
    return (x < 0 ? -x : x);
}

function parseGetParams()
{
    var getData = new Array();
    var sGet = window.location.search;
    if (sGet)
    {
        sGet = sGet.substr(1);

        var sNVPairs = sGet.split("&");

        for (var i = 0; i < sNVPairs.length; i++)
        {

            var sNV = sNVPairs[i].split("=");
            
            var sName = sNV[0];
            var sValue = sNV[1];
            getData[sName] = sValue;
        }
    }
    
    return getData;
}

window.onload = init;