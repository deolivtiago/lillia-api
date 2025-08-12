defmodule LilliaWeb.ErrorJSONTest do
  use LilliaWeb.ConnCase, async: true

  alias LilliaWeb.ErrorJSON

  test "renders 500" do
    assert %{errors: errors} = ErrorJSON.render("500.json", %{})

    assert errors == %{detail: "Internal Server Error"}
  end
end
