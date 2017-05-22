// Incomplete implementation of the PageRank algorithm

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

// Returns the page rank of an specific page.
function page_rank=get_page_rank(page, ranks, incidence_matriz, outlinks, b)
    num_pages = size(incidence_matriz);
    num_pages = num_pages(1);
    
    page_rank = (1-b)/num_pages;

    summatory = 0;
    for page = 1:num_pages
        for other = 1:num_pages
            if incidence_matriz(page, other) == 1
                summatory = summatory + ranks(other)/outlinks(other);
            end
        end
    end

    page_rank = page_rank + 0.8 * summatory;
endfunction

function ranks=complete_page_rank(incidence_matriz, outlinks, b, threshold)
    num_pages = size(incidence_matriz);
    num_pages = num_pages(1);

    ranks = ones(1, num_pages);
    ranks = ranks/num_pages;
    
    max_diff = 1;
    while max_diff > threshold do
        max_diff = 0;
        for page = 1:num_pages
            old_rank = ranks(page);
            // não deveria atualizar em cima
            ranks(page)=get_page_rank(page, ranks, incidence_matriz, outlinks, b);
            this_diff = abs(old_rank - ranks(page));
            if(this_diff > max_diff)
                max_diff = this_diff;
            end
        end
    end

endfunction

outlinks = get_outlink_count(incidence_matriz);
ranks=complete_page_rank(incidence_matriz, outlinks, 0.8, 0.0001);
disp(ranks);

// Results should be:
// 0.36 0.19 0.39 0.05
