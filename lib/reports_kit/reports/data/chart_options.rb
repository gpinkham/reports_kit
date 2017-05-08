module ReportsKit
  module Reports
    module Data
      class ChartOptions
        DEFAULT_COLORS = %w(
          #1f77b4
          #aec7e8
          #ff7f0e
          #ffbb78
          #2ca02c
          #98df8a
          #d62728
          #ff9896
          #9467bd
          #c5b0d5
          #8c564b
          #c49c94
          #e377c2
          #f7b6d2
          #7f7f7f
          #c7c7c7
          #bcbd22
          #dbdb8d
          #17becf
          #9edae5
        )
        DEFAULT_OPTIONS = {
          scales: {
            xAxes: [{
              stacked: true,
              gridLines: {
                display: false
              },
              barPercentage: 0.9,
              categoryPercentage: 0.9
            }],
            yAxes: [{
              stacked: true
            }]
          },
          legend: {
            labels: {
              usePointStyle: true
            }
          },
          tooltips: {
            xPadding: 8,
            yPadding: 7
          }
        }

        attr_accessor :data, :options

        def initialize(data, options)
          self.data = data
          self.options = options
        end

        def perform
          add_colors
          add_options
          data
        end

        private

        def add_colors
          self.data[:chart_data][:datasets] = data[:chart_data][:datasets].map.with_index do |dataset, index|
            dataset[:backgroundColor] = DEFAULT_COLORS[index % DEFAULT_COLORS.length]
            dataset
          end
        end

        def add_options
          chart_options = DEFAULT_OPTIONS
          chart_options = chart_options.deep_merge(options[:options]) if options.try(:[], :options)
          self.data[:chart_data][:options] = chart_options
        end
      end
    end
  end
end
