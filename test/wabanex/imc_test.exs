defmodule Wabanex.IMCTest do
  use ExUnit.Case, async: true

  alias Wabanex.IMC

  describe "calculate/1" do
    test "When the file exists, returns the data" do
      params = %{"filename" => "students.csv"}

      response = IMC.calculate(params)

      expected_response =
        {:ok,
         %{
           "Dani" => 23.44,
           "Diego" => 23.04,
           "Gabul" => 22.86,
           "Rafael" => 24.9,
           "Rodrigo" => 26.23
         }}

      assert expected_response == response
    end

    test "When the wrong file name is given, returns an error" do
      params = %{"filename" => "banana.csv"}

      response = IMC.calculate(params)

      expected_response = {:error, "Error while opening the file"}
      assert expected_response == response
    end
  end
end
