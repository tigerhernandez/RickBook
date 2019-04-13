<%-- 
    Document   : Main
    Created on : Apr 13, 2019, 1:01:31 AM
    Author     : c0719943
--%>

<%@page contentType="text/html" pageEncoding="windows-1252"%>
<!DOCTYPE html>
<html>
    <head>
        <title>The RickBook</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" crossorigin="anonymous">
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" crossorigin="anonymous"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.7.7/angular.min.js"></script>
        <script>
            var rmApp = angular.module('rmApp', []);
            rmApp.controller('postCtrl', function($scope, $http) {
                var baseUrl = '/RickBook/api/post';
                $scope.postList = [];
                function getItems() {
                    $http.get(baseUrl).then(
                        function(posts){
                            $scope.postList = posts.data;
                        },
                        function(error){
                            alert(error.message);
                        });
                }
                getItems();
                $scope.addItem = function() {
                    newPost = {
                        postId: $scope.newPostId,
                        postContent: $scope.newPostContent,
                        timeOfPost: $scope.newTimeOfPost
                    };
                    $http.post(baseUrl, newPost).then(
                        function() {
                            // Timeout needed because updates happen too fast
                            setTimeout(getItems(), 500);
                        },
                        function(error){
                            alert(error.message);
                        }
                    );
                };
                
                $scope.editItem = function() {
                    editPostContent = {
                        postId: $scope.editPost,
                        postContent: $scope.editPostContent,
                        postTimeStamp: $scope.editTimeStamp
                    };
                    $http.put(baseUrl + '/' + $scope.editPost, editPostContent).then(
                        function() {
                            setTimeout(getItems(), 500);
                        },
                        function(error){
                            alert(error.message);
                        }
                    );
                };
                
                $scope.delItem = function() {                    
                    $http.delete(baseUrl + '/' + $scope.delPost).then(
                        function() {
                            setTimeout(getItems(), 500);
                        },
                        function(error){
                            alert(error.message);
                        }
                    );
                };
            });
        </script>
    </head>
    <body>
       <div ng-app="rmApp" class="container">
            <div class="row" ng-controller="postCtrl">
                <div class="col-md-6">
                    <table class="table">
                        <thead class="thead-dark">
                            <tr>
                                <th>Post Id</th>
                                <th>Post Content</th>
                                <th>Time Of Post</th>
                            </tr>
                        </thead>
                        <tbody id="post-table">
                            <tr ng-repeat="post in postList">
                                <label>{{ post.postId }}</label>
                                <label>{{ post.postContent }}</label>
                                <label>{{ post.timeOfPost }}</label>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div class="col-md-6">
                    <h1>Add Post</h1>
                    <div class="form-group">
                        <label>Post<input class="form-control" ng-model="newPostId" /></label>
                    </div>
                  
                    <div class="form-group">
                        <label>Post Content<input class="form-control" ng-model="newPostContent" /></label>
                    </div>
                    <div class="form-group">
                        <label>Time of post<input class="form-control" ng-model="newTimeOfPost" /></label>
                    </div>
                    <button class="btn btn-success" ng-click="addItem()">Add</button>
                    
                    <h1>Edit Post</h1>
                    <div class="form-group">
                        <label>Post<input class="form-control" ng-model="editPost" /></label>
                  
                   </div>
                     
                    <div class="form-group">
                        <label>post Content <input class="form-control" ng-model="postId" /></label>
                    </div>
                    <div class="form-group">
                        <label>Time of Post <input class="form-control" ng-model="editPostContent" /></label>
                    </div>
                    <button class="btn btn-warning" ng-click="editItem()">Edit</button>
                    
                    <h1>Delete Post</h1>
                    <div class="form-group">
                        <label>Post <input class="form-control" ng-model="delPost" /></label>
                    </div>
                    <button class="btn btn-danger" ng-click="delItem()">Delete</button>
                </div>
            </div>
        </div>
    </body>
</html>
