require 'minitest/reporters'

class CaptainAmericaReporter < Minitest::Reporters::BaseReporter
  include Minitest::Reporters::ANSI::Code

  def start
    super

    puts bold(white("\nWhat are we waiting for, team? Let's go get'em!\n"))
  end

  def record(test)
    super

    if test.passed?
      print white('*')
    elsif test.skipped?
      print blue('=')
    elsif test.error? || test.failure != nil
      print red('=')
    end
  end

  def report
    super

    puts bold(suite_stats), "\n"
    puts non_passing, "\n"
    puts bold(results_summary), "\n"
  end

  private

  def suite_stats
    sprintf("\n\nTest run finished in %.6f seconds, %.4f tests/sec",
            total_time, count / total_time)
  end

  def non_passing
    formatted = results.map do |result|
      if result.skipped?
        blue(result.to_s)
      elsif result.error? || result.failure != nil
        red(result.to_s)
      end
    end
    formatted.join("\n")
  end

  def results_summary
    message = self.passed? ? 'Nice work, soldier.' : "We'll get 'em next time."
    text = sprintf("%s\n\n%d tests, %d assertions, %d failures, %d errors, %d skips",
                   message, count, assertions, failures, errors, skips)
    self.passed? ? white(text) : red(text)
  end
end

Minitest::Reporters.use! [CaptainAmericaReporter.new]
