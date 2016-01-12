class V1::UsersController < Lina::ApplicationController
  # def new
  define_action :new, {
    name: 'new',
    description: '',
    params: {
      type: 'object',
      properties: {
      }
    },
    return: {
    }
  } do
    # write code here, It's the same as before
  end

  # def player_rank
  define_action :player_rank, {
    name: 'player_rank',
    description: '',
    params: {
      type: 'object',
      properties: {
      }
    },
    return: {
    }
  } do
    # write code here, It's the same as before
  end

  # def ranking
  define_action :ranking, {
    name: 'ranking',
    description: '',
    params: {
      type: 'object',
      properties: {
      }
    },
    return: {
    }
  } do
    # write code here, It's the same as before
  end
end
