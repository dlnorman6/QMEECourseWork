import networkx as nx
import scipy as sc
import matplotlib.pyplot as p

## Generate a "synthetic" food web
def GenRdmAdjList(N=2, C=0.5):
    """Generates a random adjacency list of an N-species food web with "connectance probability" C, i.e. probability of a link between any pair of species in a food web
    """
    Ids = range(N)
    ALst = []
    for i in Ids:
        if sc.random.uniform(0,1,1) < C:
            Lnk = sc.random.choice(Ids,2).tolist()
            if Lnk[0] != Lnk[1]: # avoid self (e.g. cannibalistic) loops
                ALst.append(Lnk)
    return ALst

## Assign nummber of species and connectance
MaxN = 30   # no. species
C = 0.75    # connectance

## Generate adjacency list representing a random food web
AdjL = sc.array(GenRdmAdjList(MaxN,C))
AdjL

## Generate species (node) data
Sps = sc.unique(AdjL) # get species' ids
SizRan = ([-10,10]) # generate body sizes on log10 scale
Sizs = sc.random.uniform(SizRan[0],SizRan[1],MaxN)
Sizs
# visualise size distribution generated
# f1 = p.figure()
p.close('all')
p.hist(Sizs)
# p.show()
p.hist(10 ** Sizs) # raw scale
# p.show()

## Plot network, with node sizes proportional to (log) body size
p.close('all') # close open plot objects
f1 = p.figure()
# Use a circular configuration
pos = nx.circular_layout(Sps) # calculate coords
G = nx.Graph() # generate networkx graph object
G.add_nodes_from(Sps) # add nodes
G.add_edges_from(tuple(AdjL)) # add links (edges)
# Generate node sizes proportional to (log) body sizes
NodSizs = 1000*(Sizs-min(Sizs))/(max(Sizs)-min(Sizs))
nx.draw_networkx(G,pos,node_size=NodSizs) # render
# p.show()
f1.savefig('../results/DrawFW.pdf') #Save figure