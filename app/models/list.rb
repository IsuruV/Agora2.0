class List < ApplicationRecord
  has_many :apartment_lists
  has_many :apartments, through: :apartment_lists
  accepts_nested_attributes_for :apartments
  belongs_to :user
end


# <form class="w3-container" action="/users/<%=current_user.id%>/lists/add_to_list" method = "POST">
#   <input type="hidden" name="_method" value="PATCH">
#   <div class="w3-section">
#     <p>
#       <input id="<%= @apartment.locations %>" type="hidden" name="apartment[id]" value="<%= @apartment.id %>">
#       <% if current_user != nil %>
#       <% if current_user.lists.empty?%>
#         <a href="/users/<%=current_user.id%>/lists/new">Create a list.</a>
#       <% else %>
#       Add <%=@apartment.locations %> to one of your lists.
#         <% end %>
#     </p>
#     <% end %>
#     <% if current_user != nil %>
#     <% current_user.lists.each do |list|%>
#       <!-- <button type="submit" name="list[name]" value="<%= list.name%>"><%=list.name%></button> -->
#       <p>
#         <input id="<%= list.name %>" type="checkbox" name="list[ids]" value="<%=list.id%>"><%=list.name %></input>
#       </p>
#     <% end %>
#     <% else %>
#        Login or Create an Account.
#     <% end %>
#     <% if current_user != nil && !current_user.lists.empty?%>
#       <button type="submit" name="submit">Add to List</button>
#
#     <% end %>
#   </div>
# </form>
