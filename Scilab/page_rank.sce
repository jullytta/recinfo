// Implementation of the PageRank algorithm

// i,j = 1 if there is an edge from j to i
incidence_matriz = [ 0 0 1 0
                     1 0 0 0
                     1 1 0 1
                     0 0 0 0 
                    ];

// Returns the count of outlinks, i.e. links (edges) from this page to others.
function outlinks=get_outlink_count(incidence_matriz)
    outlinks = [];

    num_pages = size(incidence_matriz);
    num_pages = num_pages(1);

    adjacency_matrix = incidence_matriz';

    for page = 1:num_pages
        out = 0;
        for other = 1:num_pages
            if adjacency_matrix(page, other) == 1
                out = out + 1;
            end
        end
        outlinks = [outlinks, out];
    end
endfunction

function weights=get_weights(incidence_matriz, outlinks)
    num_pages = size(incidence_matriz);
    num_pages = num_pages(1);
    
    weights = incidence_matriz;
    
    for page = 1:num_pages
        weights(:, page) = weights(:, page)/outlinks(page);
    end    
endfunction

function ranks=page_rank(incidence_matriz, b, threshold)
    num_pages = size(incidence_matriz);
    num_pages = num_pages(1);

    ranks = ones(1, num_pages);
    ranks = ranks/num_pages;

    outlinks = get_outlink_count(incidence_matriz);
    weights = get_weights(incidence_matriz, outlinks);

    weights = weights*b + (1-b)/num_pages;
    
    // should be set to "infinity"
    abs_diff = 1000;
    while(max(abs_diff) > threshold)
        old_ranks = ranks;
        ranks = (weights*ranks')';
        abs_diff = abs(old_ranks-ranks);
    end
    
endfunction

ranks = page_rank(incidence_matriz, 0.8, 0.0001);
disp(ranks);

// Results should be:
// 0.36 0.19 0.39 0.05
