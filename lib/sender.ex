defmodule Sender do
  def send_email("poo@internet.com" = email), do: {:error, "email not sent to #{email}"}

  def send_email(email) do
    Process.sleep(3000)

    {:ok, "email sent to #{email}"}
  end

  def notify_all(emails) do
    Sender.TaskSupervisor
    |> Task.Supervisor.async_stream_nolink(emails, &send_email/1,
      max_concurrency: 2,
      ordered: false
    )
    |> Enum.to_list()
  end
end
