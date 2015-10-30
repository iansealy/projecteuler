#!/usr/bin/env python

"""This script solves the Project Euler problem "Path sum: four ways". The
problem is: Find the minimal path sum, in matrix.txt, a 31K text file
containing a 80 by 80 matrix, from the top left to the bottom right by moving
left, right, up, and down.
"""

import argparse
import csv
try:
    from urllib.request import urlopen
except ImportError:
    from urllib import urlopen
try:
    from io import StringIO
except ImportError:
    from StringIO import StringIO
from collections import defaultdict


def main(args):
    """Path sum: four ways"""

    response = urlopen(args.url)
    matrix = response.read()
    matrix = [[int(i) for i in row]
              for row in csv.reader(StringIO(matrix.decode('utf-8')))]

    rows = len(matrix)
    cols = len(matrix[0])

    # Label nodes
    node_for = []
    node = 0
    for i in range(rows):
        node_for.append([])
        for j in range(cols):
            node += 1
            node_for[i].append(node)

    # Make graph
    graph = defaultdict(lambda: defaultdict(int))

    # Up
    for i in range(1, rows):
        for j in range(cols):
            graph[node_for[i][j]][node_for[i-1][j]] = matrix[i-1][j]

    # Down
    for i in range(rows - 1):
        for j in range(cols):
            graph[node_for[i][j]][node_for[i+1][j]] = matrix[i+1][j]

    # Left
    for i in range(rows):
        for j in range(1, cols):
            graph[node_for[i][j]][node_for[i][j-1]] = matrix[i][j-1]

    # Right
    for i in range(rows):
        for j in range(cols - 1):
            graph[node_for[i][j]][node_for[i][j+1]] = matrix[i][j+1]

    # Dijkstra
    node = 1
    destination = rows * cols
    unvisited = set(range(2, destination + 1))
    dist = {}
    dist[node] = matrix[0][0]
    while destination in unvisited:
        try:
            next_nodes = graph[node].iterkeys()
        except AttributeError:
            next_nodes = graph[node].keys()
        for next_node in next_nodes:
            if (next_node not in dist or
                    dist[next_node] > dist[node] + graph[node][next_node]):
                dist[next_node] = dist[node] + graph[node][next_node]
        unvisited.discard(node)
        if node == destination:
            break
        node = sorted([n for n in unvisited if n in dist],
                      key=lambda n: dist[n])[0]

    print(dist[destination])


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Path sum: four ways')
    parser.add_argument(
        'url', metavar='URL', type=str,
        default='https://projecteuler.net/project/resources/p083_matrix.txt',
        nargs='?', help='Matrix URL')
    args = parser.parse_args()

    main(args)
