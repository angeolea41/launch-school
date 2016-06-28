require 'pry'

def prompt(message)
  Kernel.puts("=> #{message}")
end


def loan_duration_in_months(years)
  years / 12
end

def monthly_interest_rate(apr)
  (apr / 100) / 12
end

def number_of_payments(years)
  years * 12
end

def monthly_payments(loan, apr, years)
  mir = monthly_interest_rate(apr)
  nop = number_of_payments(years)

  payment = mir * (mir + 1)**nop / ((1 + mir)**nop - 1) * loan
  payment.round(2)
end

loop do
  prompt("Welcome to Mortgage Calculator")

  prompt("What is your loan amount?")
  principal = Kernel.gets().chomp().to_f

  prompt("What is the APR?")
  apr = Kernel.gets().chomp().to_f

  prompt("What is the duration of the loan in years?")
  duration = Kernel.gets().chomp().to_f

  payment = monthly_payments(principal, apr, duration)

  prompt("Your monthly payment is: $#{payment}")

  prompt("Would you like to make another calculation?")
  answer = Kernel.gets().chomp.downcase

  break unless answer == 'y'

  prompt("Thanks for using Mortgage Calculator!")
  prompt("Have a great day!")

end
