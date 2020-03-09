package command;

import controller.Facade;

public abstract class AbsCmd implements ICommand{

    protected Facade facade;

    public AbsCmd(){
        facade = new Facade();
    }

}