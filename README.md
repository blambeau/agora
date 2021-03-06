# Agora

* http://github.com/blambeau/agora

## Description

Agora (Agile Goal-Oriented Requirement Acquisition) aims at helping KAOS adopters 
(Keep All Objectives Satisfied) by providing agile tools around acquisition of 
requirement models, and goal models in particular. It provides pragmatic tools 
to write such models, present them, analyze them, and so on.

Where to start? Try the command below. Have a look at the generated image, as 
well as the minepump.ago file. Enjoy!

    ./bin/agora examples/minepump.ago | dot -Tgif -o examples/minepump.gif

## Synopsis

    agora --help

## Requirements

* yargi >= 0.1.1

## Install

    sudo gem install agora

## Features/Problems

* In generated dot graphs, the left-to-right ordering of subgoals in refinements may not follow what is 
  declared in the YAML file. The reason is that goal nodes are created first, from unordered keys of a Hash.
  (This is not the case ruby >= 1.9 fixes the problem as Hash keys are then ordered, providing a easy way to fix 
  this)

## Licence

    (The MIT License)

    Copyright (c) 2010 Bernard Lambeau & The University of Louvain

    Permission is hereby granted, free of charge, to any person obtaining
    a copy of this software and associated documentation files (the
    'Software'), to deal in the Software without restriction, including
    without limitation the rights to use, copy, modify, merge, publish,
    distribute, sublicense, and/or sell copies of the Software, and to
    permit persons to whom the Software is furnished to do so, subject to
    the following conditions:

    The above copyright notice and this permission notice shall be
    included in all copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
    EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
    MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
    IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
    CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
    TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
    SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
