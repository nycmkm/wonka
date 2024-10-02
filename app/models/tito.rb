class Tito
  BASE_URL = "https://api.tito.io/v3".freeze

  class RequestError < StandardError; end

  def events
    path = "/#{account_id}/events"

    all_pages(path, :events)
  end

  def attendees(event_id)
    checkin_list_id = checkin_list(event_id)[:slug]
    checkin_list = CheckinList.new(checkin_list_id)
    checkins = checkin_list.checkins
    tickets_ids = checkins.map { |c| c[:ticket_id] }

    tickets(event_id).filter { |t| tickets_ids.include?(t[:id]) }
  end

  def checkin_list(event_id)
    path = "/#{account_id}/#{event_id}/checkin_lists"
    all_pages(path, :checkin_lists).first
  end

  def tickets(event_id)
    path = "/#{account_id}/#{event_id}/tickets?expand=answers,questions"
    all_pages(path, :tickets)
  end

  private

  def account_id
    ENV.fetch("TITO_ACCOUNT_ID")
  end

  def all_pages(path, key, page = nil)
    params = {}

    if page
      params["page[number]"] = page
    end

    response = HTTP.
               auth("Token token=#{ENV.fetch("TITO_API_KEY")}").
               headers(accept: "application/json").
               get("#{BASE_URL}#{path}", params: params)

    if response.status != 200
      raise RequestError, "Error requesting #{path}: #{response.status}"
    end

    body = FastJsonparser.parse(response.body.to_s)

    result = body[key]

    if body[:meta] && body[:meta][:next_page]
      result += all_pages(path, key, body[:meta][:next_page])
    end

    result
  end

  class CheckinList
    BASE_URL = "https://checkin.tito.io".freeze

    def initialize(list_id)
      @list_id = list_id
    end

    def checkins
      path = "/checkin_lists/#{list_id}/checkins"
      all_pages(path, :checkin_lists)
    end

    private

    attr_reader :list_id

    def all_pages(path, key, page = 1)
      response = HTTP.
                 auth("Token token=#{ENV.fetch("TITO_API_KEY")}").
                 headers(accept: "application/json").
                 get("#{BASE_URL}#{path}", params: { page: page })

      if response.status != 200
        raise RequestError, "Error requesting #{path}: #{response.status}"
      end

      FastJsonparser.parse(response.body.to_s)
    end
  end
end
