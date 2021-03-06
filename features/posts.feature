Feature: Post operations

    @auth
    Scenario: Create posts
    	Given empty "posts"
    	Given "blogs"
		"""
		[{"title": "test_blog1"}]
		"""
		When we post to "posts"
        """
        [{"text": "test post for an open blog", "blog": "#BLOGS_ID#"}]
        """
        When we post to "posts"
        """
        [{"text": "test post for the same blog", "blog": "#BLOGS_ID#"}]
        """
        And we get "/posts?embedded={"original_creator":1}"
        Then we get list with 2 items
        """
        {"_items": [
                    {"text": "test post for an open blog", "blog": "#BLOGS_ID#", "original_creator": {"username": "test_user"}}, 
                    {"text": "test post for the same blog",  "blog": "#BLOGS_ID#", "original_creator": {"username": "test_user"}} 
	               ]}
	    """       
        
	@auth
    Scenario: Retrieve posts from blogs
        Given empty "posts"
        Given "blogs"
		"""
		[{"title": "test_blog1"}]
		"""
        When we post to "blogs"
	    """
	    [{"title": "testBlog", "language": "fr"}]
	    """
        When we post to "posts"
        """
        [{"text": "test post for an open blog", "blog": "#BLOGS_ID#"}]
        """
        And we get "/blogs/#BLOGS_ID#/posts"
		Then we get list with 1 items
		
	@auth
    Scenario: Create post with multiple items
		When we post to "posts"
		"""
		[{ "text": "first"}, {"text": "second"}, {"text": "third"}]
 		"""
		When we get "/posts?embedded={"original_creator":1}" 
		Then we get list with 1 items
		"""
        {"_items": [
                    {"text": "first", "original_creator": {"username": "test_user"}, "particular_type": "post"}
	               ]}
	    """ 
	    When we get "/items?embedded={"original_creator":1}" 
		Then we get list with 2 items
		 """
        {"_items": [
                    {"text": "second", "original_creator": {"username": "test_user"}, "particular_type":"item"},
                    {"text": "third", "original_creator": {"username": "test_user"}, "particular_type": "item"}
	               ]}
	    """        


