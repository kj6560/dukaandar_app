part of scheme_list_library;

class SchemeListScreen
    extends WidgetView<SchemeListScreen, SchemeListControllerState> {
  const SchemeListScreen(super.controllerState, {super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
        title: "Schemes",
        body: BlocConsumer<SchemeBloc, SchemeState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            if (state is LoadingSchemeList) {
              return Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Column(
                        children: [
                          CircularProgressIndicator(
                            color: Colors.teal,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text("Loading")
                        ],
                      ),
                    )
                  ],
                ),
              );
            } else if (state is LoadSchemeListSuccess) {
              var schemeList = state.response;
              return Container(
                child: ListView.builder(
                  itemCount: schemeList.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        print("implement click on scheme");
                      },
                      child: Card(
                        elevation: 4, // Adds shadow effect
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(10), // Rounded corners
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          // Adds spacing inside the card
                          child: Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.blue.shade100,
                                child: Text("${index + 1}"),
                              ),
                              const SizedBox(width: 10),
                              // Spacing between avatar and text
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      schemeList[index].schemeName,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                    Text(
                                      schemeList[index].type,
                                      style:
                                          const TextStyle(color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            } else {
              return Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Column(
                        children: [
                          CircularProgressIndicator(
                            color: Colors.teal,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text("Loading")
                        ],
                      ),
                    )
                  ],
                ),
              );
            }
          },
        ),
        profilePicUrl: "https://via.placeholder.com/150",
        name: controllerState.name,
        email: controllerState.email);
  }
}
