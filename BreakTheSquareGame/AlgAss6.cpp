//
//  AlgAss6.cpp
//  BreakTheSquareGame
//
//  Created by cory on 4/23/20.
//  Copyright © 2020 royalty. All rights reserved.
//

#include <stdio.h>
#include <limit.h>

void dijkstraAlg(int graph[V][V], int src)
{
    int currDist[V];
  
    bool toBeChecked[V];
  
    for (int i = 0; i < V; i++)
    {
        currDist[i] = INT_MAX;
        toBeChecked[i] = false;
    }
  
    currDist[src] = 0;
  
    for (int count = 0; count < V - 1; count++)
    {
        int u = minDistance(currDist, toBeChecked);
  
        toBeChecked[u] = true;
  
        for (int v = 0; v < V; v++)
  
            if (!toBeChecked[v] && graph[u][v] &&
                currDist[u] + graph[u][v] < currDist[v])
            {
                currDist[v] = currDist[u] + graph[u][v];
            }
    }

    //printSolution(dist, V);
}
