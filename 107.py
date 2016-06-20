#!/usr/bin/env python

"""This script solves the Project Euler problem "Minimal network". The problem
is: Using network.txt, a 6K text file containing a network with forty vertices,
and given in matrix form, find the maximum saving which can be achieved by
removing redundant edges whilst ensuring that the network remains connected.
"""

try:
    from urllib.request import urlopen
except ImportError:
    from urllib import urlopen


def main():
    """Minimal network"""

    # Constants
    NETWORK_URL = 'https://projecteuler.net/project/resources/p107_network.txt'

    edges = []
    total_weight = 0
    num_vertices = 0
    for i, line in enumerate(urlopen(NETWORK_URL)):
        num_vertices += 1
        for j, weight in enumerate(line.rstrip().decode('ascii').split(',')):
            if weight == '-':
                continue
            if i >= j:
                continue
            total_weight += int(weight)
            edges.append([int(weight), i, j])
    edges = sorted(edges)

    graph = {}
    minimum_weight = 0
    for edge in edges:
        weight, node1, node2 = edge

        undiscovered = set(range(num_vertices))
        s = [node1]
        while len(s):
            v = s.pop()
            if v in undiscovered:
                undiscovered.remove(v)
                if v in graph:
                    try:
                        nodes = graph[v].iterkeys()
                    except AttributeError:
                        nodes = graph[v].keys()
                    s.extend(nodes)
        if node2 in undiscovered:
            if node1 not in graph:
                graph[node1] = {}
            graph[node1][node2] = weight
            if node2 not in graph:
                graph[node2] = {}
            graph[node2][node1] = weight
            minimum_weight += weight

    print(total_weight - minimum_weight)

if __name__ == '__main__':
    main()
