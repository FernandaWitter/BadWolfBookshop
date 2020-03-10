package controller;

import domain.Book;
import domain.DomainObject;
import domain.Result;
import repository.BookDAO;
import repository.IDAO;
import strategy.*;

import java.util.ArrayList;
import java.util.HashMap;

public class Facade {
    HashMap<String, HashMap<String, ArrayList<IStrategy>>> preprocessing;
    HashMap<String, HashMap<String, ArrayList<IStrategy>>> postprocessing;
    HashMap<String, IDAO> persistence;

    public Facade() {
        // operations
        String create = "create";
        String update = "update";
        String delete = "delete";
        String find = "find";

        // domain classes
        String book = Book.class.getSimpleName();

        // strategies
        IStrategy preProcessAuthors = new BookCreationPreProcessAuthors();
        IStrategy preProcessCategories = new BookCreationPreProcessCategories();
        IStrategy preProcessPublisher = new BookCreationPreProcessPublisher();
        IStrategy postProcessAuthors = new BookSearchPostProcessAuthors();
        IStrategy postProcessCategories = new BookSearchPostProcessCategories();
        IStrategy bookDataValidation = new DataValidation();
        IStrategy bookExistenceValidation = new ExistenceValidation();
        IStrategy isbnValidation = new IsbnValidation();

        // class mapping by operation
        ArrayList<IStrategy> beforeBookSave = new ArrayList<>();
        beforeBookSave.add(bookDataValidation);
        beforeBookSave.add(bookExistenceValidation);
        beforeBookSave.add(isbnValidation);
        beforeBookSave.add(preProcessAuthors);
        beforeBookSave.add(preProcessCategories);
        beforeBookSave.add(preProcessPublisher);
        ArrayList<IStrategy> afterBookSave = new ArrayList<>();

        ArrayList<IStrategy> beforeBookUpdate = new ArrayList<>();
        beforeBookUpdate.add(bookDataValidation);
        beforeBookUpdate.add(isbnValidation);
        beforeBookUpdate.add(preProcessAuthors);
        beforeBookUpdate.add(preProcessCategories);
        beforeBookUpdate.add(preProcessPublisher);
        ArrayList<IStrategy> afterBookUpdate = new ArrayList<>();

        ArrayList<IStrategy> beforeBookFind = new ArrayList<>();
        ArrayList<IStrategy> afterBookFind = new ArrayList<>();
        afterBookFind.add(postProcessAuthors);
        afterBookFind.add(postProcessCategories);

        ArrayList<IStrategy> beforeBbookDelete = new ArrayList<>();
        ArrayList<IStrategy> afterBookDelete = new ArrayList<>();

        // strategy mapping by class
        HashMap<String, ArrayList<IStrategy>> beforeBookMap = new HashMap<>();
        beforeBookMap.put(create, beforeBookSave);
        beforeBookMap.put(update, beforeBookUpdate);
        beforeBookMap.put(delete, beforeBbookDelete);
        beforeBookMap.put(find, beforeBookFind);

        HashMap<String, ArrayList<IStrategy>> afterBookMap = new HashMap<>();
        afterBookMap.put(create, afterBookSave);
        afterBookMap.put(update, afterBookUpdate);
        afterBookMap.put(delete, afterBookDelete);
        afterBookMap.put(find, afterBookFind);

        // map mapping by class
        preprocessing = new HashMap<>();
        preprocessing.put(book, beforeBookMap);

        postprocessing = new HashMap<>();
        postprocessing.put(book, afterBookMap);

        // DAO mapping by class
        persistence = new HashMap<>();
        persistence.put(book, new BookDAO());
    }

    public Result create(DomainObject object){
        Result result = new Result();
        String objectClass = object.getClass().getSimpleName();
        ArrayList<IStrategy> preprocess = preprocessing.get(objectClass).get("create");
        for(IStrategy is : preprocess){
            is.process(object, result);
        }
        if(!result.hasMsg("error")){
            IDAO idao = persistence.get(objectClass);
            idao.create(object, result);
            ArrayList<IStrategy> postprocess = postprocessing.get(objectClass).get("create");
            for(IStrategy is : postprocess){
                is.process(object, result);
            }
        }
        return result;
    }

    public Result update(DomainObject object){
        Result result = new Result();
        String objectClass = object.getClass().getSimpleName();
        ArrayList<IStrategy> preprocess = preprocessing.get(objectClass).get("update");
        for(IStrategy is : preprocess){
            is.process(object, result);
        }
        if(!result.hasMsg("error")){
            IDAO idao = persistence.get(objectClass);
            idao.update(object, result);
            ArrayList<IStrategy> postprocess = postprocessing.get(objectClass).get("update");
            for(IStrategy is : postprocess){
                is.process(object, result);
            }
        }
        return result;
    }

    public Result delete(DomainObject object){
        Result result = new Result();
        String objectClass = object.getClass().getSimpleName();
        ArrayList<IStrategy> preprocess = preprocessing.get(objectClass).get("delete");
        for(IStrategy is : preprocess){
            is.process(object, result);
        }
        if(!result.hasMsg("error")){
            IDAO idao = persistence.get(objectClass);
            idao.delete(object, result);
            ArrayList<IStrategy> postprocess = postprocessing.get(objectClass).get("delete");
            for(IStrategy is : postprocess){
                is.process(object, result);
            }
        }
        return result;
    }

    public Result find(DomainObject object){
        Result result = new Result();
        String objectClass = object.getClass().getSimpleName();
        ArrayList<IStrategy> preprocess = preprocessing.get(objectClass).get("find");
        for(IStrategy is : preprocess){
            is.process(object, result);
        }

        if(!result.hasMsg("error")){
            IDAO idao = persistence.get(objectClass);
            idao.findActive(object, result);
            ArrayList<DomainObject> books = result.getObject(Book.class.getSimpleName());
            ArrayList<IStrategy> postprocess = postprocessing.get(objectClass).get("find");
            for(IStrategy is : postprocess){
                for(DomainObject d : books) {
                    is.process(d, result);
                }
            }
        }
        return result;
    }
}