function [Cnode, Celem, has_node_i, bnd_node] =  fem2d_init_tri(elem,nnode)
nelem = size(elem,1);
bnd_node = zeros(nnode,1);
totalEdge = [elem(:,[2,3]); elem(:,[3,1]); elem(:,[1,2])];
has_node_i = zeros(nnode,8);
has_node_i_size = zeros(nnode,1);



% Find elements containing the node i and store them in has_node_i
for i = 1 : nelem
    e1 = elem(i,1);
    e2 = elem(i,2);
    e3 = elem(i,3);

    has_node_i_size(e1) = has_node_i_size(e1)+1;
    has_node_i(e1,has_node_i_size(e1)) = i;
    has_node_i_size(e2) = has_node_i_size(e2)+1;
    has_node_i(e2,has_node_i_size(e2)) = i;
    has_node_i_size(e3) = has_node_i_size(e3)+1;
    has_node_i(e3,has_node_i_size(e3)) = i;
end
has_node_i = [has_node_i_size has_node_i];

% Cnode is a sparse matrix and nonzero entries represent the connectivity between two nodes. 
% The matrix entries are the element that contains edge between two nodes. 
Cnode = sparse(totalEdge(:,1),totalEdge(:,2),[1:nelem 1:nelem 1:nelem]',nnode,nnode);

% Celem is a cennectivity matrix between elements. If two elements share an
% edge then the corresponding values in Celem is an index of that edge.
icelem = zeros(3*nelem,1);
jcelem = zeros(3*nelem,1);
kcelem = zeros(3*nelem,1);
celem_index = 1;

% iteration over edges
for i = 1 : 3*nelem
    row = totalEdge(i,1);
    col = totalEdge(i,2);
    
    temp = Cnode(col,row);
    if temp == 0
        bnd_node(row) = 1;
        bnd_node(col) = 1;
    else
        icelem(celem_index) = Cnode(row,col);
        jcelem(celem_index) = temp;
        kcelem(celem_index) = i;
        celem_index = celem_index + 1;
        
    end
end
celem_index = celem_index - 1;
Celem = sparse(icelem(1:celem_index),jcelem(1:celem_index),kcelem(1:celem_index),nelem,nelem);
bnd_node = sparse(bnd_node);
