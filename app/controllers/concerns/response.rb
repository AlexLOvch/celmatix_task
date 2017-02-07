# frozen_string_literal: true
module Response
  def json_response(object, meta: {}, status: :ok, serializer: nil)
    if serializer
      render json: object, meta: meta, status: status, serializer: serializer
    else
      render json: object, meta: meta, status: status
    end
  end
end
