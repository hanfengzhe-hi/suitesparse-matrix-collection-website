class CollectionMatrix < ApplicationRecord

  ### Download Helpers #########################################################

  # Get the base URL for remote matrix downloads
  def self.get_base_url
    #return 'https://sparse.tamu.edu/'
    return 'https://suitesparse-collection-website.herokuapp.com/'
  end

  # Get the download URL for a given matrix and file format
  def get_url(file_format)
    base_url = CollectionMatrix.get_base_url
    if file_format == :matlab
      return "#{base_url}mat/#{self.group}/#{self.name}.mat"
    elsif file_format == :rutherford_boeing
      return "#{base_url}RB/#{self.group}/#{self.name}.tar.gz"
    elsif file_format == :matrix_market
      return "#{base_url}MM/#{self.group}/#{self.name}.tar.gz"
    elsif file_format == :svd
      return "#{base_url}svd/#{self.group}/#{self.name}_SVD.mat"
    else
      raise ArgumentError.new("Unknown matrix file type - only :matlab, :rutherford_boeing, and :matrix_market allowed")
    end
  end

  ### Filtering and Sorting Helpers ############################################

  filterrific(
    default_filter_params: { sorted_by: 'id_asc' },
    available_filters: [
      :sorted_by,
      :search_query,
      :min_id,
      :max_id,
      :min_year,
      :max_year,
      :min_rows,
      :max_rows,
      :min_cols,
      :max_cols,
      :min_nonzeros,
      :max_nonzeros,
      :min_pattern_symmetry,
      :max_pattern_symmetry,
      :min_numerical_symmetry,
      :max_numerical_symmetry,
      :min_strongly_connected_components,
      :max_strongly_connected_components,
      :min_dmperm_blocks, 
      :max_dmperm_blocks,
      :rb_type,
      :structure,
      :name_query, 
      :group_query, 
      :positive_definite,
    ]
  )

  scope :sorted_by, ->(sort_option) {
    # extract the sort direction from the param value.
    direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
    case sort_option.to_s
    when /^id_/
      # Sort by matrix ID
      order("collection_matrices.matrix_id #{ direction }")
    when /^group_/
      # Sort alphabetically by group name
      order(Arel.sql("LOWER(collection_matrices.group) #{ direction }"))
    when /^name_/
      # Sort alphabetically by matrix name
      order(Arel.sql("LOWER(collection_matrices.name) #{ direction }"))
    when /^rows_/
      # Sort by number of rows
      order("collection_matrices.num_rows #{ direction }")
    when /^cols_/
      # Sort by number of columns
      order("collection_matrices.num_cols #{ direction }")
    when /^nonzeros_/
      # Sort by number of nonzeros
      order("collection_matrices.nonzeros #{ direction }")
    when /^kind_/
      # Sort alphabetically by kind
      order("collection_matrices.kind #{ direction }")
    when /^date_/
      # Sort by matrix date field
      order("collection_matrices.date #{ direction }")
    else
      raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect }")
    end
  }

  # This method provides select options for the `sorted_by` filter select input.
  # It is called in the controller as part of `initialize_filterrific`.
  def self.options_for_sorted_by
    [
      ['ID (High to Low)',       'id_desc'      ],
      ['ID (Low to High)',       'id_asc'       ],
      ['Group (A to Z)',         'group_asc'   ],
      ['Group (Z to A)',         'group_desc'    ],
      ['Name (A to Z)',          'name_asc'     ],
      ['Name (Z to A)',          'name_desc'    ],
      ['Rows (High to Low)',     'rows_desc'    ],
      ['Rows (Low to High)',     'rows_asc'     ],
      ['Columns (High to Low)',  'cols_desc'    ],
      ['Columns (Low to High)',  'cols_asc'     ],
      ['Nonzeros (High to Low)', 'nonzeros_desc'],
      ['Nonzeros (Low to High)', 'nonzeros_asc' ],
      ['Kind (A to Z)',          'kind_asc'     ],
      ['Kind (Z to A)',          'kind_desc'    ],
      ['Date (Oldest First)',    'date_asc'     ],
      ['Date (Recent First)',    'date_desc'    ]
    ]
  end

  scope :search_query, -> (query) { 
    return nil if query.blank?

    # condition query, parse into individual keywords
    terms = query.to_s.downcase.split(/\s+/)

    # replace "*" with "%" for wildcard searches,
    # append '%', remove duplicate '%'s
    terms = terms.map { |e|
      ('%' + e.tr('*', '%') + '%').gsub(/%+/, '%')
    }
    # configure number of OR conditions for provision
    # of interpolation arguments. Adjust this if you
    # change the number of OR conditions.
    num_or_conds = 7
    where(
      terms.map {
        "LOWER(collection_matrices.name) LIKE ?
          OR LOWER(collection_matrices.description) LIKE ? 
          OR LOWER(collection_matrices.kind) LIKE ? 
          OR LOWER(collection_matrices.notes) LIKE ? 
          OR LOWER(collection_matrices.group) LIKE ?
          OR LOWER(collection_matrices.author) LIKE ?
          OR LOWER(collection_matrices.editor) LIKE ?"
      }.join(' AND '),
      *terms.map { |e| [e] * num_or_conds }.flatten
    )
  }

  def self.process_text_query(text_query)
    processed_query = ('%' + text_query.tr('*', '%') + '%').gsub(/%+/, '%')
    processed_query = processed_query.downcase
    return processed_query
  end

  scope :name_query, -> (query) { 
    return nil if query.blank?
    processed_query = CollectionMatrix.process_text_query(query)
    where("LOWER(collection_matrices.name) LIKE ?", processed_query)
  }

  scope :group_query, -> (query) { 
    return nil if query.blank?
    processed_query = CollectionMatrix.process_text_query(query)
    where("LOWER(collection_matrices.group) LIKE ?", processed_query)
  }

  # Filter by group name
  scope :group_name, -> (group) {
    where("collection_matrices.group = ?", group)
  }

  # Filter by number of rows
  scope :min_rows, -> (min_rows) {
    where("collection_matrices.num_rows >= ?", min_rows)
  }

  scope :max_rows, -> (max_rows) {
    where("collection_matrices.num_rows <= ?", max_rows)
  }

  # Filter by number of columns
  scope :min_cols, -> (min_cols) {
    where("collection_matrices.num_cols >= ?", min_cols)
  }

  scope :max_cols, -> (max_cols) {
    where("collection_matrices.num_cols <= ?", max_cols)
  }

  # Filter by number of nonzeros
  scope :min_nonzeros, -> (min_nonzeros) {
    where("collection_matrices.nonzeros >= ?", min_nonzeros)
  }

  scope :max_nonzeros, -> (max_nonzeros) {
    where("collection_matrices.nonzeros <= ?", max_nonzeros)
  }

  scope :structure, -> (structure) {
    if structure == "Square"
      where("collection_matrices.num_rows = collection_matrices.num_cols")
    elsif structure == "Rectangular"
      where.not("collection_matrices.num_rows = collection_matrices.num_cols")
    elsif structure == "Hermitian"
      where("collection_matrices.structure = ?", structure)
    else
      where("collection_matrices.structure = ?", structure.downcase)
    end
  }

  scope :rb_type, -> (rb_type) {
    where("collection_matrices.rb_type = ?", rb_type.downcase)
  }

  # Filter by ID
  scope :min_id, -> (min_id) {
    where("collection_matrices.matrix_id >= ?", min_id)
  }

  scope :max_id, -> (max_id) {
    where("collection_matrices.matrix_id <= ?", max_id)
  }

  # Filter by year
  scope :min_year, -> (min_year) {
    where("collection_matrices.date >= ?", min_year)
  }

  scope :max_year, -> (max_year) {
    where("collection_matrices.date <= ?", max_year)
  }

  # Filter by pattern symmetry
  scope :min_pattern_symmetry, -> (min_pattern_symmetry) {
    where("collection_matrices.pattern_symmetry >= ?", min_pattern_symmetry.to_f/100)
  }

  scope :max_pattern_symmetry, -> (max_pattern_symmetry) {
    where("collection_matrices.pattern_symmetry <= ?", max_pattern_symmetry.to_f/100)
  }

  # Filter by numerical symmetry
  scope :min_numerical_symmetry, -> (min_numerical_symmetry) {
    where("collection_matrices.numeric_symmetry >= ?", min_numerical_symmetry.to_f/100)
  }

  scope :max_numerical_symmetry, -> (max_numerical_symmetry) {
    where("collection_matrices.numeric_symmetry <= ?", max_numerical_symmetry.to_f/100)
  }

  # Filter by number of strongly connected components
  scope :min_strongly_connected_components, -> (min_strongly_connected_components) {
    where("collection_matrices.num_strongly_connected_components >= ?", min_strongly_connected_components)
  }

  scope :max_strongly_connected_components, -> (max_strongly_connected_components) {
    where("collection_matrices.num_strongly_connected_components <= ?", max_strongly_connected_components)
  }

  # Filter by positive definiteness
  scope :positive_definite, -> (pos_def) {
    if (pos_def == "Any")
      nil
    else
      where("collection_matrices.positive_definite = ?", pos_def.downcase)
    end
  }

  ##############################################################################

end
