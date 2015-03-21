// Copyright (c) 2015 Matthew J. Runyan

// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:

// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.

// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

// this renders the rects using LOVE with a simple lua script included
//#define USE_LOVE2D

#include "StripPacking.h"
#include <sstream>
#include <random>
#ifndef USE_LOVE2D
#include <iostream>
#endif

using namespace StripPacking;

const int MAX_RECT_DIM = 100;
const int MIN_RECT_DIM = 8;
const int MAX_STRIP_WIDTH = 200;
const int NUMBER_OF_RECTS = 40;

Rect RandomRect()
{
    auto f = []() {
        return MIN_RECT_DIM + (rand() % (int)(MAX_RECT_DIM - MIN_RECT_DIM + 1));
    };
    return Rect(f(),f());
}

int main()
{
#ifdef USE_LOVE2D
    std::stringstream ss;
#endif

    StripProblem solver(MAX_STRIP_WIDTH);

    for (int i = 0; i < NUMBER_OF_RECTS; ++i)
        solver.AddRect( RandomRect() );

#ifdef USE_LOVE2D
    ss << '{';
    solver.SetAlgorithm<Algorithms::NFDH>();
    ss << solver.Solve();
    solver.SetAlgorithm<Algorithms::FFDH>();
    ss << solver.Solve();
    solver.SetAlgorithm<Algorithms::BFDH>();
    ss << solver.Solve();
    ss << '}';

    std::string str = ss.str();
    for (char &c : str) if ( c == '\n' ) c = ' ';
    std::string command = "screen -d -m love . ";
    command = (command + '"' + str + '"' + " 1");
    system(command.c_str());
#else
    solver.SetAlgorithm<Algorithms::NFDH>();
    std::cout << solver.Solve();
    solver.SetAlgorithm<Algorithms::FFDH>();
    std::cout << solver.Solve();
    solver.SetAlgorithm<Algorithms::BFDH>();
    std::cout << solver.Solve();
#endif
    return 0;
}
