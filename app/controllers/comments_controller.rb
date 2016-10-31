# class CommentsController < ApplicationController
#
#   def create
#     # binding.pry
#     @comment = Comment.create(comment_params)
#     @list = List.find(params['comment']['list_id'])
#     @apartment = @list.apartments.find(params['comment']['apartment_id'])
#     @apartment_list = ApartmentList.find_by(apartment_id: @apartment.id, list_id: @list.id)
#     @apartment_list.comments.create(text: params['comment']['text'])
#     redirect_to(:back)
#   end
#
#   def destroy
#     @comment = Comment.find_by_id(params[:id])
#     @comment.destroy
#     redirect_to(:back)
#   end
#
#   def comment_params
#     params.require(:comment).permit(
#         :text
#     )
#   end
#
# end



class CommentsController < ApplicationController

 def create
   @comment = Comment.create(comments_params)
   @list = List.find(params['comment']['list_id'])
   @apartment = @list.apartments.find(params['comment']['apartment_id'])
   @apartment_list = ApartmentList.find_by(apartment_id: @apartment.id, list_id: @list.id)
   @apartment_list.comments.create(text: params['comment']['text'])
   redirect_to(:back)
 end


 def destroy
   @comment = Comment.find_by_id(params[:id])
   @comment.destroy
   redirect_to(:back)
 end


 def comments_params
   params.require(:comment).permit(
     attributes:[
       :text
     ]
   )
 end

end
